import Foundation
import SessionPlus
import ProcedureKit
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData
import XcodeServerProcedures

public typealias ManagerErrorCompletion = (_ error: Error?) -> Void
public typealias ManagerEventsCompletion = (_ events: [XcodeServerProcedureEvent]) -> Void
public typealias ManagerCredentials = (username: String, password: String)

public protocol ManagerAuthorizationDelegate {
    func credentialsForServer(withFQDN fqdn: String?) -> ManagerCredentials?
}

public class Manager {
    
    private let container: NSPersistentContainer
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    private var clients: [String : APIClient] = [:]
    private var authorizationDelegate: ManagerAuthorizationDelegate?
    
    public init(container: NSPersistentContainer, authorizationDelegate: ManagerAuthorizationDelegate? = nil) {
        self.container = container
        self.authorizationDelegate = authorizationDelegate
        procedureQueue.delegate = self
        procedureQueue.maxConcurrentOperationCount = 1
    }
    
    private func client(forFQDN fqdn: String) throws -> APIClient {
        if let client = clients[fqdn] {
            return client
        }
        
        let client = try APIClient(fqdn: fqdn, authorizationDelegate: self)
        client.session.configuration.timeoutIntervalForRequest = 8
        client.session.configuration.timeoutIntervalForResource = 16
        client.session.configuration.httpCookieAcceptPolicy = .never
        client.session.configuration.httpShouldSetCookies = false
        
        clients[fqdn] = client
        
        return client
    }
    
    public func resetClient(forFQDN fqdn: String) {
        clients[fqdn] = nil
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
    public func ping(server: Server, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let procedure = CheckConnectionProcedure(client: client)
        procedure.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(procedure)
    }
    
    public func createServer(withFQDN fqdn: String, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let procedure = CreateServerProcedure(container: container, input: fqdn)
        procedure.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(procedure)
    }
    
    public func deleteServer(_ server: Server, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let procedure = DeleteServerProcedure(container: container, object: server)
        procedure.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(procedure)
    }
    
    public func syncServer(withFQDN fqdn: String, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let server = container.viewContext.server(withFQDN: fqdn) else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let sync = SyncServerProcedure(container: container, server: server, apiClient: client)
        sync.addDidFinishBlockObserver { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(sync)
    }
    
    /// Retrieve the version information about the `Server`
    /// Updates the supplied `Server` entity with the response.
    public func syncVersionData(forServer server: Server, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetVersionProcedure(client: client)
        let update = UpdateVersionProcedure(container: container, server: server)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves all `Bot`s from the `Server`
    /// Updates the supplied `Server` entity with the response.
    public func syncBots(forServer server: Server, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetBotsProcedure(client: client)
        let update = UpdateServerBotsProcedure(container: container, server: server)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves the information for a given `Bot` from the `Server`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncBot(bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetBotProcedure(client: client, input: bot.identifier)
        let update = UpdateBotProcedure(container: container, bot: bot)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Gets the cumulative integration stats for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncStats(forBot bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetBotStatsProcedure(client: client, input: bot.identifier)
        let update = UpdateBotStatsProcedure(container: container, bot: bot)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Begin a new integration for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func triggerIntegration(forBot bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let trigger = TriggerBotIntegrationProcedure(client: client, input: bot.identifier)
        let create = CreateIntegrationProcedure(container: container, bot: bot)
        create.injectResult(from: trigger)
        create.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([trigger, create])
    }
    
    /// Gets a list of `Integration` for a specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncIntegrations(forBot bot: Bot, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetBotIntegrationsProcedure(client: client, input: bot.identifier)
        let update = UpdateBotIntegrationsProcedure(container: container, bot: bot)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Gets a single `Integration` from the `XcodeServer`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncIntegration(integration: Integration, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            queue.async {
                completion(XcodeServerProcedureError.bot)
            }
            return
        }
        
        guard let server = bot.server else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetIntegrationProcedure(client: client, input: integration.identifier)
        let update = UpdateIntegrationProcedure(container: container, integration: integration)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves the `Repository` commits for a specified `Integration`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncCommits(forIntegration integration: Integration, queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            queue.async {
                completion(XcodeServerProcedureError.bot)
            }
            return
        }
        
        guard let server = bot.server else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetIntegrationCommitsProcedure(client: client, input: integration.identifier)
        let update = UpdateIntegrationCommitsProcedure(container: container, integration: integration)
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
        guard let bot = integration.bot else {
            queue.async {
                completion(XcodeServerProcedureError.bot)
            }
            return
        }
        
        guard let server = bot.server else {
            queue.async {
                completion(XcodeServerProcedureError.xcodeServer)
            }
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            queue.async {
                completion(error)
            }
            return
        }
        
        let retrieve = GetIntegrationIssuesProcedure(client: client, input: integration.identifier)
        let update = UpdateIntegrationIssuesProcedure(container: container, integration: integration)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    public func syncIncompleteIntegrations(queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let integrations = container.viewContext.incompleteIntegrations()
        let fqdns = integrations.compactMap({ $0.bot?.server?.fqdn })
        
        var apiClients: [String: APIClient] = [:]
        
        fqdns.forEach({ (fqdn) in
            do {
                let client = try self.client(forFQDN: fqdn)
                apiClients[fqdn] = client
            } catch {
                print(error)
            }
        })
        
        let sync = SyncIncompleteIntegrationsProcedure(container: container, apiClients: apiClients)
        sync.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(sync)
    }
    
    public func syncIncompleteCommits(queue: DispatchQueue = .main, completion: @escaping ManagerErrorCompletion) {
        let commits = container.viewContext.incompleteCommits()
        var fqdns = [String]()
        
        commits.forEach({
            guard let revisionBlueprints = $0.revisionBlueprints else {
                return
            }
            
            revisionBlueprints.forEach({ (revisionBlueprint) in
                guard let integration = revisionBlueprint.integration else {
                    return
                }
                
                if let fqdn = integration.bot?.server?.fqdn {
                    fqdns.append(fqdn)
                }
            })
        })
        
        var apiClients: [String: APIClient] = [:]
        
        fqdns.forEach({ (fqdn) in
            do {
                let client = try self.client(forFQDN: fqdn)
                apiClients[fqdn] = client
            } catch {
                print(error)
            }
        })
        
        let sync = SyncIncompleteCommitsProcedure(container: container, apiClients: apiClients)
        sync.addDidFinishBlockObserver() { (proc, error) in
            queue.async {
                completion(error)
            }
        }
        
        procedureQueue.addOperation(sync)
    }
    
    public func syncOutOfDateServers(since date: Date, queue: DispatchQueue = .main, completion: @escaping ManagerEventsCompletion) {
        let servers = container.viewContext.serversLastUpdatedOnOrBefore(date)
        var events: [XcodeServerProcedureEvent] = []
        
        guard servers.count > 0 else {
            queue.async {
                completion(events)
            }
            return
        }
        
        var syncCount: Int = 0
        var completeCount: Int = 0
        
        for server in servers {
            let client: APIClient
            do {
                client = try self.client(forFQDN: server.fqdn)
            } catch {
                print(error)
                continue
            }
            
            syncCount += 1
            
            let sync = SyncServerProcedure(container: container, server: server, apiClient: client)
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
            
            procedureQueue.addOperation(sync)
        }
    }
}

extension Manager: APIClientAuthorizationDelegate {
    public func authorization(for fqdn: String?) -> HTTP.Authorization? {
        guard let credentials = authorizationDelegate?.credentialsForServer(withFQDN: fqdn) else {
            return nil
        }
        
        return .basic(username: credentials.username, password: credentials.password)
    }
}

extension Manager: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        
    }
}

#endif
