import Foundation
import ProcedureKit
import XcodeServer
import XcodeServerAPI
import XcodeServerProcedures

public typealias ManagerErrorCompletion = (_ error: Swift.Error?) -> Void
public typealias ManagerEventsCompletion = (_ events: [XcodeServerProcedureEvent]) -> Void
public typealias ManagerCredentials = (username: String, password: String)

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
    }
    
    private func client(forServer id: Server.ID) throws -> APIClient {
        if let client = clients[id] {
            return client
        }
        
        let client = try APIClient(fqdn: id, authorizationDelegate: self)
        clients[id] = client
        return client
    }
    
    @available(*, deprecated, renamed: "resetClient(forServer:)")
    public func resetClient(forFQDN fqdn: String) {
        resetClient(forServer: fqdn)
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
            queue.async {
                completion(Error.invalidClient(server))
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
                queue.async {
                    completion(error)
                }
            }
        }
    }
    
    public func createServer(withId id: Server.ID, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let _server = Server(id: id)
        let procedure = CreateServerProcedure(destination: store, identifiable: _server)
        procedure.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(procedure)
    }
    
    public func deleteServer(_ server: Server, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let procedure = DeleteServerProcedure(destination: store, identifiable: server)
        procedure.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(procedure)
    }
    
    public func syncServer(withId id: Server.ID, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let client = try? self.client(forServer: id) else {
            queue.async {
                completion(Error.invalidClient(id))
            }
            return
        }
        
        let _server = Server(id: id)
        let sync = SyncServerProcedure(source: client, destination: store, identifiable: _server)
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
            queue.async {
                completion(Error.invalidClient(id))
            }
            return
        }
        
        let _server = Server(id: id)
        let get = GetVersionProcedure(source: client, input: _server.id)
        let update = UpdateVersionProcedure(destination: store, identifiable: _server)
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
            queue.async {
                completion(Error.invalidClient(server.id))
            }
            return
        }
        
        let get = GetBotsProcedure(source: client)
        let update = UpdateServerBotsProcedure(destination: store, identifiable: server)
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
            queue.async {
                completion(Error.noProvidedServerId)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            queue.async {
                completion(Error.invalidClient(id))
            }
            return
        }
        
        let get = GetBotProcedure(source: client, input: bot.id)
        let update = UpdateBotProcedure(destination: store, identifiable: bot)
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
            queue.async {
                completion(Error.noProvidedServerId)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            queue.async {
                completion(Error.invalidClient(id))
            }
            return
        }
        
        let get = GetBotStatsProcedure(source: client, input: bot.id)
        let update = UpdateBotStatsProcedure(destination: store, identifiable: bot)
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
            queue.async {
                completion(Error.noProvidedServerId)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            queue.async {
                completion(Error.invalidClient(id))
            }
            return
        }
        
        client.runIntegration(forBotWithIdentifier: bot.id) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success:
                completion(nil)
            }
        }
    }
    
    /// Gets a list of `Integration` for a specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncIntegrations(forBot bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let id = bot.serverId else {
            queue.async {
                completion(Error.noProvidedServerId)
            }
            return
        }
        
        guard let client = try? self.client(forServer: id) else {
            queue.async {
                completion(Error.invalidClient(id))
            }
            return
        }
        
        let get = GetBotIntegrationsProcedure(source: client, input: bot.id)
        let update = UpdateBotIntegrationsProcedure(destination: store, identifiable: bot)
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
            queue.async {
                completion(Error.noProvidedServerId)
            }
            return
        }
        
        guard let client = try? self.client(forServer: serverId) else {
            queue.async {
                completion(Error.invalidClient(serverId))
            }
            return
        }
        
        let get = GetIntegrationProcedure(source: client, input: integration.id)
        let update = UpdateIntegrationProcedure(destination: store, identifiable: integration)
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
            queue.async {
                completion(Error.noProvidedServerId)
            }
            return
        }
        
        guard let client = try? self.client(forServer: serverId) else {
            queue.async {
                completion(Error.invalidClient(serverId))
            }
            return
        }
        
        let retrieve = GetIntegrationCommitsProcedure(source: client, input: integration.id)
        let update = UpdateIntegrationCommitsProcedure(destination: store, identifiable: integration)
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
            queue.async {
                completion(Error.noProvidedServerId)
            }
            return
        }
        
        guard let client = try? self.client(forServer: serverId) else {
            queue.async {
                completion(Error.invalidClient(serverId))
            }
            return
        }
        
        let get = GetIntegrationIssuesProcedure(source: client, input: integration.id)
        let update = UpdateIntegrationIssuesProcedure(destination: store, identifiable: integration)
        update.injectResult(from: get)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([get, update])
    }
    
    public func syncIncompleteIntegrations(queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        store.getServers { (result) in
            switch result {
            case .failure(let error):
                queue.async {
                    completion(error)
                }
            case .success(let servers):
                let integrations = servers.flatMap({ $0.incompleteIntegrations })
                self.syncIncompleteIntegrations(integrations, queue: queue, completion: completion)
            }
        }
    }
    
    private func syncIncompleteIntegrations(_ integrations: [Integration], queue: DispatchQueue, completion: @escaping ManagerErrorCompletion) {
        guard integrations.count > 0 else {
            queue.async {
                completion(nil)
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
            
            let op = SyncIntegrationProcedure(source: client, destination: store, identifiable: integration)
            operations.append(op)
        }
        
        let group = GroupProcedure(operations: operations)
        group.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(group)
    }
    
    public func syncIncompleteCommits(queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        store.getServers { (result) in
            switch result {
            case .failure(let error):
                queue.async {
                    completion(error)
                }
            case .success(let servers):
                let commits = servers.flatMap({ $0.incompleteCommits })
                let ids = Set(commits.compactMap({ $0.integrationId }))
                self.syncIncompleteCommits(Array(ids), queue: queue, completion: completion)
            }
        }
    }
    
    private func syncIncompleteCommits(_ integrations: [Integration.ID], queue: DispatchQueue, completion: @escaping ManagerErrorCompletion) {
        guard integrations.count > 0 else {
            queue.async {
                completion(nil)
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
                
                let sync = SyncIntegrationCommitsProcedure(source: client, destination: self.store, identifiable: integration)
                self.subQueue.addOperation(sync)
            }
            
            operations.append(get)
        }
        
        let group = GroupProcedure(operations: operations)
        group.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }

        procedureQueue.addOperation(group)
    }
    
    public func syncOutOfDateServers(since date: Date, queue: DispatchQueue = .main, completion: @escaping ManagerEventsCompletion) {
        var events: [XcodeServerProcedureEvent] = []
        
        store.getServers { (result) in
            switch result {
            case .failure(let error):
                print(error)
                queue.async {
                    completion(events)
                }
            case .success(let servers):
                let outOfDate = servers.filter({ $0.modified < date })
                guard outOfDate.isEmpty == false else {
                    queue.async {
                        completion(events)
                    }
                    return
                }
                
                var syncCount: Int = 0
                var completeCount: Int = 0
                
                for server in outOfDate {
                    guard let client = try? self.client(forServer: server.id) else {
                        continue
                    }
                    
                    syncCount += 1
                    
                    let sync = SyncServerProcedure(source: client, destination: self.store, identifiable: server)
                    sync.addDidFinishBlockObserver() { (proc, error) in
                        completeCount += 1
                        
                        if let output = proc.output.success {
                            events.append(contentsOf: output)
                        }
                        
                        if syncCount == completeCount {
                            queue.async {
                                completion(events)
                            }
                        }
                    }
                    
                    self.procedureQueue.addOperation(sync)
                }
            }
        }
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
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Swift.Error?) {
        
    }
}

extension APIClient: AnyQueryable {
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
