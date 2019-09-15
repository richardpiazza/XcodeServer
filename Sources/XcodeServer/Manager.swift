import Foundation
import CodeQuickKit
import ProcedureKit
import XcodeServerCommon
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData
import XcodeServerProcedures

public typealias ManagerErrorCompletion = (_ error: Swift.Error?) -> Void

public class Manager {
    
    private let container: NSPersistentContainer
    private var clients: [String : APIClient] = [:]
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public enum Error: Swift.Error, LocalizedError {
        case unhandled
        case response
        case managedObjectContext
        case xcodeServer
        case bot
        case repository
        
        public var errorDescription: String? {
            switch self {
            case .unhandled: return "An unknown error occured."
            case .response: return "The API response was unexpectedly nil."
            case .managedObjectContext: return "The parameter entity has an invalid NSManagedObjectContext."
            case .xcodeServer: return "An Xcode Server could not be identified for the supplied parameter entity."
            case .bot: return "A Bot could not be identified for the supplied parameter entity."
            case .repository: return "A Repository could not be identified for the supplied parameter entity."
            }
        }
    }
    
    public init(container: NSPersistentContainer) {
        self.container = container
        procedureQueue.delegate = self
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
    public func ping(xcodeServer: Server, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
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
    
    /// Retreive the version information about the `XcodeServer`
    /// Updates the supplied `XcodeServer` entity with the response.
    public func syncVersionData(forXcodeServer xcodeServer: Server, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.versions { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Version Data for Server '\(xcodeServer.fqdn)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let server = privateContext.object(with: xcodeServer.objectID) as? Server {
                        server.update(withVersion: value.0, api: value.1)
                        server.lastUpdate = Date()
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Retrieves all `Bot`s from the `XcodeServer`
    /// Updates the supplied `XcodeServer` entity with the response.
    public func syncBots(forXcodeServer xcodeServer: Server, completion: @escaping ManagerErrorCompletion) {
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.bots { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Bots for Server '\(xcodeServer.fqdn)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let server = privateContext.object(with: xcodeServer.objectID) as? Server {
                        server.update(withBots: value)
                        server.lastUpdate = Date()
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Retrieves the information for a given `Bot` from the `XcodeServer`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncBot(bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let xcodeServer = bot.server else {
            completion(Error.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.bot(withIdentifier: bot.identifier) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Bot '\(bot.identifier)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let b = privateContext.object(with: bot.objectID) as? Bot {
                        b.update(withBot: value)
                        b.lastUpdate = Date()
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Gets the cumulative integration stats for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncStats(forBot bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let xcodeServer = bot.server else {
            completion(Error.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.stats(forBotWithIdentifier: bot.identifier) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Stats for Bot '\(bot.identifier)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let b = privateContext.object(with: bot.objectID) as? Bot {
                        b.stats?.update(withStats: value)
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Begin a new integration for the specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func triggerIntegration(forBot bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let xcodeServer = bot.server else {
            completion(Error.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.runIntegration(forBotWithIdentifier: bot.identifier) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Triggered Integration for Bot '\(bot.identifier)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let b = privateContext.object(with: bot.objectID) as? Bot {
                        b.update(withIntegrations: [value])
                        b.lastUpdate = Date()
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Gets a list of `Integration` for a specified `Bot`.
    /// Updates the supplied `Bot` entity with the response.
    public func syncIntegrations(forBot bot: Bot, completion: @escaping ManagerErrorCompletion) {
        guard let xcodeServer = bot.server else {
            completion(Error.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.integrations(forBotWithIdentifier: bot.identifier) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Integrations for Bot '\(bot.identifier)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let b = privateContext.object(with: bot.objectID) as? Bot {
                        b.update(withIntegrations: value)
                        b.lastUpdate = Date()
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Gets a single `Integration` from the `XcodeServer`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncIntegration(integration: Integration, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            completion(Error.bot)
            return
        }
        
        guard let xcodeServer = bot.server else {
            completion(Error.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.integration(withIdentifier: integration.identifier) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Integration '\(integration.identifier)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let i = privateContext.object(with: integration.objectID) as? Integration {
                        i.update(withIntegration: value)
                        i.lastUpdate = Date()
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Retrieves the `Repository` commits for a specified `Integration`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncCommits(forIntegration integration: Integration, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            completion(Error.bot)
            return
        }
        
        guard let xcodeServer = bot.server else {
            completion(Error.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.commits(forIntegrationWithIdentifier: integration.identifier) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Commits for Integration '\(integration.identifier)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    let repositories = privateContext.repositories()
                    let privateContextIntegration = privateContext.object(with: integration.objectID) as? Integration
                    
                    for repository in repositories {
                        repository.update(withIntegrationCommits: value, integration: privateContextIntegration)
                    }
                    
                    privateContextIntegration?.hasRetrievedCommits = true
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
    
    /// Retrieves `Issue` related to a given `Integration`.
    /// Updates the supplied `Integration` entity with the response.
    public func syncIssues(forIntegration integration: Integration, completion: @escaping ManagerErrorCompletion) {
        guard let bot = integration.bot else {
            completion(Error.bot)
            return
        }
        
        guard let xcodeServer = bot.server else {
            completion(Error.xcodeServer)
            return
        }
        
        let client: APIClient
        do {
            client = try self.client(forFQDN: xcodeServer.fqdn)
        } catch {
            completion(error)
            return
        }
        
        client.issues(forIntegrationWithIdentifier: integration.identifier) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let value):
                print("Retrieved Issues for Integration '\(integration.identifier)'")
                self.container.performBackgroundTask({ (privateContext) in
                    privateContext.automaticallyMergesChangesFromParent = true
                    
                    if let i = privateContext.object(with: integration.objectID) as? Integration {
                        i.issues?.update(withIntegrationIssues: value)
                        i.hasRetrievedIssues = true
                    }
                    
                    do {
                        try privateContext.save()
                    } catch {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                })
            }
        }
    }
}

extension Manager: APIClientAuthorizationDelegate {
    public func authorization(for fqdn: String?) -> HTTP.Authorization? {
        return nil
    }
    
    public func clearCredentials(for fqdn: String?) {
        
    }
}

extension Manager: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Swift.Error?) {
        
    }
}

#endif
