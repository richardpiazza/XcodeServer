import XcodeServer
import Foundation
#if canImport(CoreData)
import CoreData
import CoreDataPlus

extension PersistentContainer: ServerPersistable {
    public func persistServer(_ server: Server) async throws -> Server {
        var result: Server!
        try persistenceContext.performSynchronously { context in
            let _server: ManagedServer
            if let existing = ManagedServer.server(server.id, in: context) {
                _server = existing
            } else {
                PersistentContainer.logger.info("Creating SERVER [\(server.id)]")
                _server = context.make()
            }
            _server.update(server, cascadeDelete: false, context: context)
            _server.lastUpdate = Date()
            
            result = Server(_server)
        }
        return result
    }
    
    public func removeServer(withId id: Server.ID) async throws {
        try persistenceContext.performSynchronously { context in
            guard let server = ManagedServer.server(id, in: context) else {
                throw XcodeServerError.serverNotFound(id)
            }
            
            PersistentContainer.logger.info("Deleting SERVER [\(id)]")
            context.delete(server)
        }
    }
}

extension PersistentContainer: BotPersistable {
    public func persistBot(_ bot: Bot, forServer id: Server.ID) async throws -> Bot {
        var result: Bot!
        try persistenceContext.performSynchronously { context in
            let _bot: ManagedBot
            if let existing = ManagedBot.bot(bot.id, in: context) {
                _bot = existing
                if _bot.server == nil {
                    _bot.server = ManagedServer.server(id, in: context)
                }
            } else {
                guard let server = ManagedServer.server(id, in: context) else {
                    throw XcodeServerError.serverNotFound(id)
                }
                
                PersistentContainer.logger.info("Creating BOT '\(bot.name)' [\(bot.id)]")
                _bot = context.make()
                _bot.server = server
            }
            
            _bot.update(bot, cascadeDelete: false, context: context)
            _bot.lastUpdate = Date()
            
            result = Bot(_bot)
        }
        return result
    }
    
    public func persistBots(_ bots: [Bot], forServer id: Server.ID, cascadeDelete: Bool) async throws -> [Bot] {
        var results: [Bot]!
        try persistenceContext.performSynchronously { context in
            guard let server = ManagedServer.server(id, in: context) else {
                throw XcodeServerError.serverNotFound(id)
            }
            
            server.update(Set(bots), cascadeDelete: cascadeDelete, context: context)
            results = (server.bots as? Set<ManagedBot> ?? []).map { Bot($0) }
        }
        return results
    }
    
    public func removeBot(withId id: Bot.ID) async throws {
        try persistenceContext.performSynchronously { context in
            guard let bot = ManagedBot.bot(id, in: context) else {
                throw XcodeServerError.botNotFound(id)
            }
            
            PersistentContainer.logger.info("Deleting BOT '\(bot.name ?? "")' [\(id)]")
            context.delete(bot)
        }
    }
    
    public func persistStats(_ stats: Bot.Stats, forBot id: Bot.ID) async throws -> Bot.Stats {
        var result: Bot.Stats!
        try persistenceContext.performSynchronously { context in
            guard let bot = ManagedBot.bot(id, in: context) else {
                throw XcodeServerError.botNotFound(id)
            }
            
            if bot.stats == nil {
                PersistentContainer.logger.info("Creating STATS for BOT '\(bot.name ?? "")' [\(id)]")
                bot.stats = context.make()
            }
            
            bot.stats?.update(stats, context: context)
            
            result = Bot.Stats(bot.stats!)
        }
        return result
    }
}

extension PersistentContainer: IntegrationPersistable {
    public func persistIntegration(_ integration: Integration, forBot id: Bot.ID) async throws -> Integration {
        var result: Integration!
        try persistenceContext.performSynchronously { context in
            let _integration: ManagedIntegration
            if let existing = ManagedIntegration.integration(integration.id, in: context) {
                _integration = existing
                if _integration.bot == nil {
                    _integration.bot = ManagedBot.bot(id, in: context)
                }
            } else {
                guard let bot = ManagedBot.bot(id, in: context) else {
                    throw XcodeServerError.botNotFound(id)
                }
                
                PersistentContainer.logger.info("Creating INTEGRATION '\(integration.number)' [\(integration.id)]")
                _integration = context.make()
                _integration.bot = bot
            }
            
            _integration.update(integration, context: context)
            
            result = Integration(_integration)
        }
        return result
    }
    
    public func persistIntegrations(_ integrations: [Integration], forBot id: Bot.ID, cascadeDelete: Bool) async throws -> [Integration] {
        var results: [Integration] = []
        try persistenceContext.performSynchronously { context in
            guard let bot = ManagedBot.bot(id, in: context) else {
                throw XcodeServerError.botNotFound(id)
            }
            
            bot.update(integrations, cascadeDelete: cascadeDelete, context: context)
            results = (bot.integrations as? Set<ManagedIntegration> ?? []).map { Integration($0) }
            
//            for integration in integrations {
//                let _integration: ManagedIntegration
//                if let existing = ManagedIntegration.integration(integration.id, in: context) {
//                    _integration = existing
//                    if _integration.bot == nil {
//                        _integration.bot = ManagedBot.bot(id, in: context)
//                    }
//                } else {
//                    guard let bot = ManagedBot.bot(id, in: context) else {
//                        throw XcodeServerError.botNotFound(id)
//                    }
//
//                    PersistentContainer.logger.info("Creating INTEGRATION '\(integration.number)' [\(integration.id)]")
//                    _integration = context.make()
//                    _integration.bot = bot
//                }
//
//                _integration.update(integration, context: context)
//
//                results.append(Integration(_integration))
//            }
        }
        return results
    }
    
    public func removeIntegration(withId id: Integration.ID) async throws {
        try persistenceContext.performSynchronously { context in
            guard let integration = ManagedIntegration.integration(id, in: context) else {
                throw XcodeServerError.integrationNotFound(id)
            }
            
            PersistentContainer.logger.info("Deleting INTEGRATION '\(integration.number)' [\(id)]")
            context.delete(integration)
        }
    }
    
    public func persistCommits(_ commits: [SourceControl.Commit], forIntegration id: Integration.ID) async throws -> [SourceControl.Commit] {
        var results: [SourceControl.Commit] = []
        try persistenceContext.performSynchronously { context in
            guard let integration = ManagedIntegration.integration(id, in: context) else {
                throw XcodeServerError.integrationNotFound(id)
            }
            
            integration.hasRetrievedCommits = true
            
            commits.forEach { commit in
                guard let remoteId = commit.remoteId else {
                    return
                }
                
                let repository: ManagedRepository
                if let existing = ManagedRepository.repository(remoteId, in: context) {
                    repository = existing
                } else {
                    PersistentContainer.logger.info("Creating REMOTE [\(remoteId)]")
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
    
    public func persistIssues(_ issues: Integration.IssueCatalog, forIntegration id: Integration.ID) async throws -> Integration.IssueCatalog {
        var result: Integration.IssueCatalog!
        try persistenceContext.performSynchronously { context in
            guard let integration = ManagedIntegration.integration(id, in: context) else {
                throw XcodeServerError.integrationNotFound(id)
            }
            
            integration.hasRetrievedIssues = true
            integration.issues?.update(issues, context: context)
            
            guard let catalog = integration.issues else {
                throw XcodeServerError.undefinedError(nil)
            }
            
            result = Integration.IssueCatalog(catalog)
        }
        return result
    }
    
    public func persistArchive(_ archive: Data, forIntegration id: Integration.ID) async throws -> Data {
        throw XcodeServerError.notImplemented
    }
}

extension PersistentContainer: SourceControlPersistable {
    public func persistRemote(_ remote: SourceControl.Remote) async throws -> SourceControl.Remote {
        var result: SourceControl.Remote!
        try persistenceContext.performSynchronously { context in
            let repository: ManagedRepository
            if let existing = ManagedRepository.repository(remote.id, in: context) {
                repository = existing
            } else {
                PersistentContainer.logger.info("Creating REMOTE [\(remote.id)]")
                repository = context.make()
            }
            
            repository.update(remote, context: context)
            
            result = SourceControl.Remote(repository)
        }
        return result
    }
    
    public func removeRemote(withId id: SourceControl.Remote.ID) async throws {
        try persistenceContext.performSynchronously { context in
            guard let remote = ManagedRepository.repository(id, in: context) else {
                throw XcodeServerError.remoteNotFound(id)
            }
            
            PersistentContainer.logger.info("Deleting REMOTE [\(id)]")
            context.delete(remote)
        }
    }
}

extension PersistentContainer: EntityPersistable {}
#endif
