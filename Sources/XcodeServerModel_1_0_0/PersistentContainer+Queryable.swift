import XcodeServer
#if canImport(CoreData)
import CoreData
import CoreDataPlus

extension PersistentContainer: ServerQueryable {
    public func servers() async throws -> [XcodeServer.Server] {
        let servers = Server.servers(in: viewContext)
        return servers.map { server in
            viewContext.mapSynchronously(server, { XcodeServer.Server($0) })
        }
    }
    
    public func server(withId id: XcodeServer.Server.ID) async throws -> XcodeServer.Server {
        guard let server = Server.server(id, in: viewContext) else {
            throw XcodeServerError.serverNotFound(id)
        }
        
        return viewContext.mapSynchronously(server, { XcodeServer.Server($0) })
    }
}

extension PersistentContainer: BotQueryable {
    public func bots() async throws -> [XcodeServer.Bot] {
        let bots = Bot.bots(in: viewContext)
        return bots.map { bot in
            viewContext.mapSynchronously(bot, { XcodeServer.Bot($0) })
        }
    }
    
    public func bots(forServer id: XcodeServer.Server.ID) async throws -> [XcodeServer.Bot] {
        let bots = Bot.bots(forServer: id, in: viewContext)
        return bots.map { bot in
            viewContext.mapSynchronously(bot, { XcodeServer.Bot($0) })
        }
    }
    
    public func bot(withId id: XcodeServer.Bot.ID) async throws -> XcodeServer.Bot {
        guard let bot = Bot.bot(id, in: viewContext) else {
            throw XcodeServerError.botNotFound(id)
        }
        
        return viewContext.mapSynchronously(bot, { XcodeServer.Bot($0) })
    }
    
    public func stats(forBot id: XcodeServer.Bot.ID) async throws -> XcodeServer.Bot.Stats {
        guard let bot = Bot.bot(id, in: viewContext) else {
            throw XcodeServerError.botNotFound(id)
        }
        
        guard let stats = bot.stats else {
            throw XcodeServerError.undefinedError(nil)
        }
        
        return viewContext.mapSynchronously(stats, { XcodeServer.Bot.Stats($0) })
    }
}

extension PersistentContainer: IntegrationQueryable {
    public func integrations() async throws -> [XcodeServer.Integration] {
        let integrations = Integration.integrations(in: viewContext)
        return integrations.map { integration in
            viewContext.mapSynchronously(integration, { XcodeServer.Integration($0) })
        }
    }
    
    public func integration(withId id: XcodeServer.Integration.ID) async throws -> XcodeServer.Integration {
        guard let integration = Integration.integration(id, in: viewContext) else {
            throw XcodeServerError.integrationNotFound(id)
        }
        
        return viewContext.mapSynchronously(integration, { XcodeServer.Integration($0) })
    }
    
    public func integrations(forBot id: XcodeServer.Bot.ID) async throws -> [XcodeServer.Integration] {
        let integrations = Integration.integrations(forBot: id, in: viewContext)
        return integrations.map { integration in
            viewContext.mapSynchronously(integration, { XcodeServer.Integration($0) })
        }
    }
    
    public func commits(forIntegration id: XcodeServer.Integration.ID) async throws -> [SourceControl.Commit] {
        guard let integration = Integration.integration(id, in: viewContext) else {
            throw XcodeServerError.integrationNotFound(id)
        }
        
        guard let blueprints = integration.revisionBlueprints as? Set<RevisionBlueprint> else {
            return []
        }
        
        let commits = blueprints.compactMap { $0.commit }
        return commits.map { commit in
            viewContext.mapSynchronously(commit, { SourceControl.Commit($0) })
        }
    }
    
    public func issues(forIntegration id: XcodeServer.Integration.ID) async throws -> XcodeServer.Integration.IssueCatalog {
        guard let integration = Integration.integration(id, in: viewContext) else {
            throw XcodeServerError.integrationNotFound(id)
        }
        
        guard let issues = integration.issues else {
            return XcodeServer.Integration.IssueCatalog()
        }
        
        return viewContext.mapSynchronously(issues, { XcodeServer.Integration.IssueCatalog($0) })
    }
    
    public func archive(forIntegration id: XcodeServer.Integration.ID) async throws -> Data {
        throw XcodeServerError.notImplemented
    }
}

extension PersistentContainer: SourceControlQueryable {
    public func remotes() async throws -> [SourceControl.Remote] {
        let repositories = Repository.repositories(in: viewContext)
        return repositories.map { repository in
            viewContext.mapSynchronously(repository, { SourceControl.Remote($0) })
        }
    }
    
    public func remote(withId id: SourceControl.Remote.ID) async throws -> SourceControl.Remote {
        guard let repository = Repository.repository(id, in: viewContext) else {
            throw XcodeServerError.remoteNotFound(id)
        }
        
        return viewContext.mapSynchronously(repository, { SourceControl.Remote($0) })
    }
}
#endif
