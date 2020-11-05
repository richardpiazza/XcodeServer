import Foundation
import ProcedureKit
import XcodeServer
import XcodeServerAPI
import XcodeServerProcedures

public typealias ManagerErrorCompletion = (_ error: Swift.Error?) -> Void
public typealias ManagerCredentials = (username: String, password: String)
public typealias ManagerServerIdsCompletion = (_ serverIds: [Server.ID], _ error: Swift.Error?) -> Void
public typealias ManagerIntegrationIdsCompletion = (_ serverIds: [Integration.ID], _ error: Swift.Error?) -> Void

public protocol ManagerAuthorizationDelegate {
    func credentialsForServer(withFQDN fqdn: String?) -> ManagerCredentials?
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class Manager {
    
    public enum Error: Swift.Error {
        case noProvidedServerId
        case invalidClient(_ id: Server.ID)
    }
    
    private let store: (AnyQueryable & AnyPersistable)
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    private let subQueue: ProcedureQueue = ProcedureQueue()
    private var clients: [Server.ID : APIClient] = [:]
    private var authorizationDelegate: ManagerAuthorizationDelegate?
    
    public init(store: (AnyQueryable & AnyPersistable), authorizationDelegate: ManagerAuthorizationDelegate? = nil) {
        self.store = store
        self.authorizationDelegate = authorizationDelegate
        procedureQueue.delegate = self
        procedureQueue.maxConcurrentOperationCount = 1
        ProcedureKit.Log.enabled = false
    }
    
    private func client(forServer id: Server.ID) throws -> APIClient {
        if let client = clients[id] {
            return client
        }
        
        let client = try APIClient(fqdn: id, authorizationDelegate: self)
        clients[id] = client
        return client
    }
    
    public func resetClient(forServer id: Server.ID) {
        clients[id] = nil
    }
    
    /// Ping the Xcode Server.
    ///
    /// Sends a simple request to the Xcode Server api endpoint `/ping`.
    ///
    /// - note: A status code of '204' indicates success.
    ///
    /// - parameter server: The `Server` of which to test connectivity
    /// - parameter queue: `DispatchQueue` on which the `completion` block will be executed.
    /// - parameter completion: Block result handler to execute upon completion of operations.
    public func ping(server: Server.ID, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let client = try? self.client(forServer: server) else {
            let error = Error.invalidClient(server)
            InternalLog.utility.error("Ping Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        client.ping { (result) in
            switch result {
            case .success:
                queue.async {
                    completion(nil)
                }
            case .failure(let error):
                InternalLog.utility.error("Ping Failed", error: error)
                queue.async {
                    completion(error)
                }
            }
        }
    }
    
    /// Tests a connection to the Xcode Server using the `/versions` endpoint.
    ///
    /// Unlike `/ping`, the `/versions` endpoint requires authorization to complete successfully.
    ///
    /// - parameter server: The `Server` of which to test connectivity
    /// - parameter queue: `DispatchQueue` on which the `completion` block will be executed.
    /// - parameter completion: Block result handler to execute upon completion of operations.
    public func testConnection(server: Server.ID, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let client = try? self.client(forServer: server) else {
            let error = Error.invalidClient(server)
            InternalLog.utility.error("Test Connection Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        client.versions { (result) in
            switch result {
            case .success:
                queue.async {
                    completion(nil)
                }
            case .failure(let error):
                InternalLog.utility.error("Test Connection Failed", error: error)
                queue.async {
                    completion(error)
                }
            }
        }
    }
    
    /// Create a `Server` entity in the destination store (`AnyQueryable & AnyPersistable`).
    ///
    /// - parameter id: The unique identifier (FQDN/IP) of the server.
    /// - parameter queue: `DispatchQueue` on which the `completion` block will be executed.
    /// - parameter completion: Block result handler to execute upon completion of the primary operation.
    public func createServer(withId id: Server.ID, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let procedure = CreateServerProcedure(destination: store, input: id)
        procedure.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations(procedure)
    }
    
    public func deleteServer(_ server: Server, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let procedure = DeleteServerProcedure(destination: store, input: server)
        procedure.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(procedure)
    }
    
    public func syncServer(withId id: Server.ID, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let client = try? self.client(forServer: id) else {
            let error = Error.invalidClient(id)
            InternalLog.utility.error("Sync Server Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let server = Server(id: id)
        let sync = SyncServerProcedure(source: client, destination: store, server: server)
        sync.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(sync)
    }
    
    /// Retrieve the version information about the `Server`
    /// Updates the supplied `Server` entity with the response.
    public func syncVersionsForServer(withId id: Server.ID, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let client = try? self.client(forServer: id) else {
            let error = Error.invalidClient(id)
            InternalLog.utility.error("Sync Server Versions Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let _server = Server(id: id)
        let get = GetVersionProcedure(source: client, input: _server.id)
        let update = UpdateVersionProcedure(destination: store, server: _server)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    /// Retrieves all `Bot`s from the `Server`
    /// Updates the supplied `Server` entity with the response.
    public func syncBots(forServer server: Server, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let client = try? self.client(forServer: server.id) else {
            let error = Error.invalidClient(server.id)
            InternalLog.utility.error("Sync Bots Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let get = GetBotsProcedure(source: client)
        let update = UpdateServerBotsProcedure(destination: store, server: server)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    /// Retrieves the information for a given `Bot` from the `Server`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncBot(bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let id = bot.serverId else {
            let error = Error.noProvidedServerId
            InternalLog.utility.error("Sync Bot Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            let error = Error.invalidClient(id)
            InternalLog.utility.error("Sync Bot Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let get = GetBotProcedure(source: client, input: bot.id)
        let update = UpdateBotProcedure(destination: store, bot: bot)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    /// Gets the cumulative integration stats for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncStats(forBot bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let id = bot.serverId else {
            let error = Error.noProvidedServerId
            InternalLog.utility.error("Sync Bot Stats Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            let error = Error.invalidClient(id)
            InternalLog.utility.error("Sync Bot Stats Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let get = GetBotStatsProcedure(source: client, input: bot.id)
        let update = UpdateBotStatsProcedure(destination: store, bot: bot)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    /// Begin a new integration for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func triggerIntegration(forBot bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let id = bot.serverId else {
            let error = Error.noProvidedServerId
            InternalLog.utility.error("Trigger Integration Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            let error = Error.invalidClient(id)
            InternalLog.utility.error("Trigger Integration Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        client.runIntegration(forBotWithIdentifier: bot.id) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success:
                completion(nil)
                NotificationCenter.default.postBotDidChange(id)
            }
        }
    }
    
    /// Gets a list of `Integration` for a specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncIntegrations(forBot bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let id = bot.serverId else {
            let error = Error.noProvidedServerId
            InternalLog.utility.error("Sync Integrations Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            let error = Error.invalidClient(id)
            InternalLog.utility.error("Sync Integrations Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let get = GetBotIntegrationsProcedure(source: client, input: bot.id)
        let update = UpdateBotIntegrationsProcedure(destination: store, bot: bot)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    /// Gets a single `Integration` from the `XcodeServer`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncIntegration(integration: Integration, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let serverId = integration.serverId else {
            let error = Error.noProvidedServerId
            InternalLog.utility.error("Sync Integration Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        guard let client = try? self.client(forServer: serverId) else {
            let error = Error.invalidClient(serverId)
            InternalLog.utility.error("Sync Integration Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let get = GetIntegrationProcedure(source: client, input: integration.id)
        let update = UpdateIntegrationProcedure(destination: store)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    /// Retrieves the `Repository` commits for a specified `Integration`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncCommits(forIntegration integration: Integration, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let serverId = integration.serverId else {
            let error = Error.noProvidedServerId
            InternalLog.utility.error("Sync Integration Commits Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        guard let client = try? self.client(forServer: serverId) else {
            let error = Error.invalidClient(serverId)
            InternalLog.utility.error("Sync Integration Commits Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetIntegrationCommitsProcedure(source: client, input: integration.id)
        let update = UpdateIntegrationCommitsProcedure(destination: store, integration: integration)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves `Issue` related to a given `Integration`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncIssues(forIntegration integration: Integration, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let serverId = integration.serverId else {
            let error = Error.noProvidedServerId
            InternalLog.utility.error("Sync Integration Issues Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        guard let client = try? self.client(forServer: serverId) else {
            let error = Error.invalidClient(serverId)
            InternalLog.utility.error("Sync Integration Issues Failed", error: error)
            queue.async {
                completion(error)
            }
            return
        }
        
        let get = GetIntegrationIssuesProcedure(source: client, input: integration.id)
        let update = UpdateIntegrationIssuesProcedure(destination: store, integration: integration)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    public func syncIncompleteIntegrations(queue: DispatchQueue = .main, completion: @escaping ManagerIntegrationIdsCompletion) {
        store.getServers { (result) in
            switch result {
            case .failure(let error):
                queue.async {
                    completion([], error)
                }
            case .success(let servers):
                let integrations = servers.flatMap({ $0.incompleteIntegrations })
                self.syncIncompleteIntegrations(integrations, queue: queue, completion: completion)
            }
        }
    }
    
    private func syncIncompleteIntegrations(_ integrations: [Integration], queue: DispatchQueue, completion: @escaping ManagerIntegrationIdsCompletion) {
        guard integrations.count > 0 else {
            queue.async {
                completion([], nil)
            }
            return
        }
        
        var operations: [Procedure] = []
        integrations.forEach { (integration) in
            guard let server = integration.serverId else {
                return
            }
            
            guard let client = try? self.client(forServer: server) else {
                return
            }
            
            let op = SyncIntegrationProcedure(source: client, destination: store, integration: integration)
            operations.append(op)
        }
        
        guard operations.count > 0 else {
            queue.async {
                completion([], nil)
            }
            return
        }
        
        InternalLog.utility.info("Syncing '\(operations.count)' Incomplete Integrations")
        
        let group = GroupProcedure(operations: operations)
        group.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(integrations.map({ $0.id }), error)
            }
        }
        
        procedureQueue.addOperation(group)
    }
    
    public func syncIncompleteCommits(queue: DispatchQueue = .main, completion: @escaping ManagerIntegrationIdsCompletion) {
        store.getServers { (result) in
            switch result {
            case .failure(let error):
                queue.async {
                    completion([], error)
                }
            case .success(let servers):
                let commits = servers.flatMap({ $0.incompleteCommits })
                let ids = Set(commits.compactMap({ $0.integrationId }))
                self.syncIncompleteCommits(Array(ids), queue: queue, completion: completion)
            }
        }
    }
    
    private func syncIncompleteCommits(_ integrations: [Integration.ID], queue: DispatchQueue, completion: @escaping ManagerIntegrationIdsCompletion) {
        guard integrations.count > 0 else {
            queue.async {
                completion([], nil)
            }
            return
        }
        
        var operations: [Procedure] = []
        
        integrations.forEach { (id) in
            let get = GetIntegrationProcedure(source: store, input: id)
            get.addDidFinishBlockObserver { (proc, error) in
                guard let integration = proc.output.success else {
                    return
                }
                
                guard let serverId = integration.serverId else {
                    return
                }
                
                guard let client = try? self.client(forServer: serverId) else {
                    return
                }
                
                let sync = SyncIntegrationCommitsProcedure(source: client, destination: self.store, integration: integration)
                self.subQueue.addOperation(sync)
            }
            
            operations.append(get)
        }
        
        guard operations.count > 0 else {
            queue.async {
                completion([], nil)
            }
            return
        }
        
        InternalLog.utility.info("Syncing '\(operations.count)' Incomplete Commits")
        
        let group = GroupProcedure(operations: operations)
        group.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(integrations, error)
            }
        }

        procedureQueue.addOperation(group)
    }
    
    public func syncOutOfDateServers(since date: Date, queue: DispatchQueue = .main, completion: @escaping ManagerServerIdsCompletion) {
        store.getServers { (result) in
            switch result {
            case .failure(let error):
                print(error)
                queue.async {
                    completion([], error)
                }
            case .success(let servers):
                let outOfDate = servers.filter({ $0.modified < date })
                self.syncOutOfDateServers(outOfDate, queue: queue, completion: completion)
            }
        }
    }
    
    private func syncOutOfDateServers(_ servers: [XcodeServer.Server], queue: DispatchQueue = .main, completion: @escaping ManagerServerIdsCompletion) {
        guard servers.isEmpty == false else {
            queue.async {
                completion([], nil)
            }
            return
        }
        
        var operations: [Procedure] = []
        
        servers.forEach { (server) in
            guard let client = try? self.client(forServer: server.id) else {
                return
            }
            
            let sync = SyncServerProcedure(source: client, destination: self.store, server: server)
            operations.append(sync)
        }
        
        guard operations.count > 0 else {
            queue.async {
                completion([], nil)
            }
            return
        }
        
        InternalLog.utility.info("Syncing '\(operations.count)' Out-of-Date Servers")
        
        let group = GroupProcedure(operations: operations)
        group.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(servers.map({ $0.id }), error)
            }
        }
        
        procedureQueue.addOperation(group)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
extension Manager: APIClientAuthorizationDelegate {
    public func credentials(for fqdn: String) -> (username: String, password: String)? {
        return authorizationDelegate?.credentialsForServer(withFQDN: fqdn)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
extension Manager: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didAddProcedure procedure: Procedure, context: Any?) {
        InternalLog.utility.debug("Enqueued Procedure '\(procedure)'")
    }
    
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Swift.Error?) {
        
    }
}

extension Server {
    var incompleteIntegrations: [Integration] {
        return bots.flatMap({ $0.incompleteIntegrations })
    }
    
    var incompleteCommits: [SourceControl.Commit] {
        return bots.flatMap({ $0.incompleteCommits })
    }
}

extension Bot {
    var incompleteIntegrations: [Integration] {
        return integrations.filter({ $0.step != .completed })
    }
    
    var incompleteCommits: [SourceControl.Commit] {
        return integrations.flatMap({ $0.incompleteCommits })
    }
}

extension Integration {
    var incompleteCommits: [SourceControl.Commit] {
        return (commits ?? []).filter({
            $0.message.isEmpty && $0.contributor.name.isEmpty
        })
    }
}
