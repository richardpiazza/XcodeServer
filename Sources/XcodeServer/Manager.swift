import Foundation
import CodeQuickKit
import ProcedureKit
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData
import XcodeServerProcedures

public typealias ManagerErrorCompletion = (_ error: Error?) -> Void

public class Manager {
    
    private let container: NSPersistentContainer
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    private var clients: [String : APIClient] = [:]
    private var authorizationDelegate: APIClientAuthorizationDelegate?
    
    public init(container: NSPersistentContainer, authorizationDelegate: APIClientAuthorizationDelegate? = nil) {
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
    
    private func resetClient(forFQDN fqdn: String) {
        clients[fqdn] = nil
    }
    
    /// Ping the Xcode Server.
    /// A Status code of '204' indicates success.
    public func ping(server: Server, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let procedure = CheckConnectionProcedure(client: client)
        procedure.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperation(procedure)
    }
    
    /// Retreive the version information about the `Server`
    /// Updates the supplied `Server` entity with the response.
    public func syncVersionData(forServer server: Server, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetVersionProcedure(client: client)
        let update = UpdateVersionProcedure(container: container, server: server)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves all `Bot`s from the `Server`
    /// Updates the supplied `Server` entity with the response.
    public func syncBots(forServer server: Server, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetBotsProcedure(client: client)
        let update = UpdateServerBotsProcedure(container: container, server: server)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves the information for a given `Bot` from the `Server`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncBot(bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            completion(XcodeServerProcedureError.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetBotProcedure(client: client, input: bot.identifier)
        let update = UpdateBotProcedure(container: container, bot: bot)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Gets the cumulative integration stats for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncStats(forBot bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            completion(XcodeServerProcedureError.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetBotStatsProcedure(client: client, input: bot.identifier)
        let update = UpdateBotStatsProcedure(container: container, bot: bot)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Begin a new integration for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func triggerIntegration(forBot bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            completion(XcodeServerProcedureError.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let trigger = TriggerBotIntegrationProcedure(client: client, input: bot.identifier)
        let create = CreateIntegrationProcedure(container: container, bot: bot)
        create.injectResult(from: trigger)
        create.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([trigger, create])
    }
    
    /// Gets a list of `Integration` for a specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncIntegrations(forBot bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let server = bot.server else {
            completion(XcodeServerProcedureError.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetBotIntegrationsProcedure(client: client, input: bot.identifier)
        let update = UpdateBotIntegrationsProcedure(container: container, bot: bot)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Gets a single `Integration` from the `XcodeServer`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncIntegration(integration: Integration, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            completion(XcodeServerProcedureError.bot)
            return
        }
        
        guard let server = bot.server else {
            completion(XcodeServerProcedureError.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetIntegrationProcedure(client: client, input: integration.identifier)
        let update = UpdateIntegrationProcedure(container: container, integration: integration)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves the `Repository` commits for a specified `Integration`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncCommits(forIntegration integration: Integration, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            completion(XcodeServerProcedureError.bot)
            return
        }
        
        guard let server = bot.server else {
            completion(XcodeServerProcedureError.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetIntegrationCommitsProcedure(client: client, input: integration.identifier)
        let update = UpdateIntegrationCommitsProcedure(container: container, integration: integration)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    /// Retrieves `Issue` related to a given `Integration`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncIssues(forIntegration integration: Integration, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            completion(XcodeServerProcedureError.bot)
            return
        }
        
        guard let server = bot.server else {
            completion(XcodeServerProcedureError.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: server.fqdn)
        } catch {
            completion(error)
            return
        }
        
        let retrieve = GetIntegrationIssuesProcedure(client: client, input: integration.identifier)
        let update = UpdateIntegrationIssuesProcedure(container: container, integration: integration)
        update.injectResult(from: retrieve)
        update.addDidFinishBlockObserver() { (proc, error) in
            completion(error)
        }
        
        procedureQueue.addOperations([retrieve, update])
    }
    
    public func syncIncompleteIntegrations(completion: @escaping ManagerErrorCompletion) {
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
            completion(error)
        }
        
        procedureQueue.addOperation(sync)
    }
    
    public func syncIncompleteCommits(completion: @escaping ManagerErrorCompletion) {
        let commits = container.viewContext.incompleteCommits()
        var fqdns = [String]()
        
        commits.forEach({
            guard let revisionBluerints = $0.revisionBlueprints else {
                return
            }
            
            revisionBluerints.forEach({ (revisionBlueprint) in
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
            completion(error)
        }
        
        procedureQueue.addOperation(sync)
    }
    
    public func syncOutOfDateServers(since date: Date) {
        let servers = container.viewContext.serversLastUpdatedOnOrBefore(date)
        
        for server in servers {
            let client: APIClient
            do {
                client = try self.client(forFQDN: server.fqdn)
            } catch {
                print(error)
                continue
            }
            
            let version = SyncServerProcedure(container: container, server: server, apiClient: client)
            let bots = SyncServerBotsProcedure(container: container, server: server, apiClient: client)
            bots.addDependency(version)
            
            procedureQueue.addOperations([version, bots])
        }
    }
}

extension Manager: APIClientAuthorizationDelegate {
    public func authorization(for fqdn: String?) -> HTTP.Authorization? {
        return authorizationDelegate?.authorization(for: fqdn)
    }
    
    public func clearCredentials(for fqdn: String?) {
        authorizationDelegate?.clearCredentials(for: fqdn)
    }
}

extension Manager: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        switch procedure {
        case is SyncServerBotsProcedure:
            guard error == nil else {
                print(error!)
                return
            }
            
            let sync = procedure as! SyncServerBotsProcedure
            let server = container.viewContext.object(with: sync.objectID) as! Server
            for bot in (server.bots ?? []) {
                let stats = SyncBotStatsProcedure(container: container, bot: bot, apiClient: sync.apiClient)
                let next = SyncBotIntegrationsProcedure(container: container, bot: bot, apiClient: sync.apiClient)
                next.addDependency(stats)
                queue.addOperations([stats, next])
            }
        case is SyncBotIntegrationsProcedure:
            guard error == nil else {
                print(error!)
                return
            }
            
            let sync = procedure as! SyncBotIntegrationsProcedure
            let bot = container.viewContext.object(with: sync.objectID) as! Bot
            for integration in (bot.integrations ?? []) {
                let next = SyncIntegrationProcedure(container: container, integration: integration, apiClient: sync.apiClient)
                queue.addOperation(next)
            }
        case is SyncIntegrationProcedure:
            guard error == nil else {
                print(error!)
                return
            }
            
            let sync = procedure as! SyncIntegrationProcedure
            let integration = container.viewContext.object(with: sync.objectID) as! Integration
            
            let issues = SyncIntegrationIssuesProcedure(container: container, integration: integration, apiClient: sync.apiClient)
            let commits = SyncIntegrationCommitsProcedure(container: container, integration: integration, apiClient: sync.apiClient)
            
            queue.addOperations([issues, commits])
        default:
            break
        }
    }
}

#endif
