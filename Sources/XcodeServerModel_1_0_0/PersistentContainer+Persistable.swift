import XcodeServer
import Foundation
#if canImport(CoreData)
import CoreData
import CoreDataPlus

extension PersistentContainer: ServerPersistable {
    public func persistServer(_ server: XcodeServer.Server) async throws -> XcodeServer.Server {
        var result: XcodeServer.Server!
        try newBackgroundContext().performSynchronously { context in
            let _server = Server.server(server.id, in: context) ?? context.make()
            _server.update(server, context: context)
            _server.lastUpdate = Date()
            
            result = XcodeServer.Server(_server)
        }
        return result
    }
    
    public func removeServer(withId id: XcodeServer.Server.ID) async throws {
        try newBackgroundContext().performSynchronously { context in
            guard let server = Server.server(id, in: context) else {
                throw XcodeServerError.serverNotFound(id)
            }
            
            context.delete(server)
        }
    }
    
    public func persistBots(_ bots: [XcodeServer.Bot], forServer id: XcodeServer.Server.ID) async throws -> [XcodeServer.Bot] {
        var results: [XcodeServer.Bot]!
        try newBackgroundContext().performSynchronously { context in
            guard let server = Server.server(id, in: context) else {
                throw XcodeServerError.serverNotFound(id)
            }
            
            server.update(Set(bots), context: context)
            results = (server.bots as? Set<Bot> ?? []).map { XcodeServer.Bot($0) }
        }
        return results
    }
}

extension PersistentContainer: BotPersistable {
    public func persistBot(_ bot: XcodeServer.Bot, forServer id: XcodeServer.Server.ID) async throws -> XcodeServer.Bot {
        var result: XcodeServer.Bot!
        try newBackgroundContext().performSynchronously { context in
            let _bot: Bot
            if let existing = Bot.bot(bot.id, in: context) {
                _bot = existing
            } else {
                guard let server = Server.server(id, in: context) else {
                    throw XcodeServerError.serverNotFound(id)
                }
                
                _bot = context.make()
                _bot.server = server
            }
            
            _bot.update(bot, context: context)
            _bot.lastUpdate = Date()
            
            result = XcodeServer.Bot(_bot)
        }
        return result
    }
    
    public func removeBot(withId id: XcodeServer.Bot.ID) async throws {
        try newBackgroundContext().performSynchronously { context in
            guard let bot = Bot.bot(id, in: context) else {
                throw XcodeServerError.botNotFound(id)
            }
            
            context.delete(bot)
        }
    }
    
    public func persistStats(_ stats: XcodeServer.Bot.Stats, forBot id: XcodeServer.Bot.ID) async throws -> XcodeServer.Bot.Stats {
        var result: XcodeServer.Bot.Stats!
        try newBackgroundContext().performSynchronously { context in
            guard let bot = Bot.bot(id, in: context) else {
                throw XcodeServerError.botNotFound(id)
            }
            
            if bot.stats == nil {
                bot.stats = context.make()
            }
            
            bot.stats?.update(stats, context: context)
            
            result = XcodeServer.Bot.Stats(bot.stats!)
        }
        return result
    }
}

extension PersistentContainer: IntegrationPersistable {
    public func persistIntegration(_ integration: XcodeServer.Integration, forBot id: XcodeServer.Bot.ID) async throws -> XcodeServer.Integration {
        var result: XcodeServer.Integration!
        try newBackgroundContext().performSynchronously { context in
            let _integration: Integration
            if let existing = Integration.integration(integration.id, in: context) {
                _integration = existing
            } else {
                guard let bot = Bot.bot(id, in: context) else {
                    throw XcodeServerError.botNotFound(id)
                }
                
                _integration = context.make()
                _integration.bot = bot
            }
            
            _integration.update(integration, context: context)
            
            result = XcodeServer.Integration(_integration)
        }
        return result
    }
    
    public func persistIntegrations(_ integrations: [XcodeServer.Integration], forBot id: XcodeServer.Bot.ID) async throws -> [XcodeServer.Integration] {
        var results: [XcodeServer.Integration] = []
        try newBackgroundContext().performSynchronously { context in
            for integration in integrations {
                let _integration: Integration
                if let existing = Integration.integration(integration.id, in: context) {
                    _integration = existing
                } else {
                    guard let bot = Bot.bot(id, in: context) else {
                        throw XcodeServerError.botNotFound(id)
                    }
                    
                    _integration = context.make()
                    _integration.bot = bot
                }
                
                _integration.update(integration, context: context)
                
                results.append(XcodeServer.Integration(_integration))
            }
        }
        return results
    }
    
    public func removeIntegration(withId id: XcodeServer.Integration.ID) async throws {
        try newBackgroundContext().performSynchronously { context in
            guard let integration = Integration.integration(id, in: context) else {
                throw XcodeServerError.integrationNotFound(id)
            }
            
            context.delete(integration)
        }
    }
    
    public func persistCommits(_ commits: [SourceControl.Commit], forIntegration id: XcodeServer.Integration.ID) async throws -> [SourceControl.Commit] {
        var results: [SourceControl.Commit] = []
        try newBackgroundContext().performSynchronously { context in
            guard let integration = Integration.integration(id, in: context) else {
                throw XcodeServerError.integrationNotFound(id)
            }
            
            integration.hasRetrievedCommits = true
            
            commits.forEach { commit in
                guard let remoteId = commit.remoteId else {
                    return
                }
                
                let repository: Repository
                if let existing = Repository.repository(remoteId, in: context) {
                    repository = existing
                } else {
                    repository = context.make()
                    repository.identifier = remoteId
                }
                
                repository.update([commit], integration: integration, context: context)
            }
        }
        // TODO: Should this return? Process 'Repository' for the commit ids?
        results.append(contentsOf: commits)
        return results
    }
    
    public func persistIssues(_ issues: XcodeServer.Integration.IssueCatalog, forIntegration id: XcodeServer.Integration.ID) async throws -> XcodeServer.Integration.IssueCatalog {
        var result: XcodeServer.Integration.IssueCatalog!
        try newBackgroundContext().performSynchronously { context in
            guard let integration = Integration.integration(id, in: context) else {
                throw XcodeServerError.integrationNotFound(id)
            }
            
            integration.hasRetrievedIssues = true
            integration.issues?.update(issues, context: context)
            
            guard let catalog = integration.issues else {
                throw XcodeServerError.undefinedError(nil)
            }
            
            result = XcodeServer.Integration.IssueCatalog(catalog)
        }
        return result
    }
    
    public func persistArchive(_ archive: Data, forIntegration id: XcodeServer.Integration.ID) async throws -> Data {
        throw XcodeServerError.notImplemented
    }
}

extension PersistentContainer: SourceControlPersistable {
    public func persistRemote(_ remote: SourceControl.Remote) async throws -> SourceControl.Remote {
        var result: SourceControl.Remote!
        try newBackgroundContext().performSynchronously { context in
            let repository: Repository
            if let existing = Repository.repository(remote.id, in: context) {
                repository = existing
            } else {
                repository = context.make()
            }
            
            repository.update(remote, context: context)
            
            result = SourceControl.Remote(repository)
        }
        return result
    }
    
    public func removeRemote(withId id: SourceControl.Remote.ID) async throws {
        try newBackgroundContext().performSynchronously { context in
            guard let remote = Repository.repository(id, in: context) else {
                throw XcodeServerError.remoteNotFound(id)
            }
            
            context.delete(remote)
        }
    }
}

extension PersistentContainer: EntityPersistable {}
#endif
