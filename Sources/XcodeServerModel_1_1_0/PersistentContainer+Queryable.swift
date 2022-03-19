import XcodeServer
#if canImport(CoreData)
import CoreData
import CoreDataPlus

extension PersistentContainer: ServerQueryable {
    public func servers() async throws -> [XcodeServer.Server] {
        try viewContext.fetchSynchronously(Server.fetchServers(), mapping: { XcodeServer.Server($0) })
    }
    
    public func server(withId id: XcodeServer.Server.ID) async throws -> XcodeServer.Server {
        guard let server = try viewContext.fetchSynchronously(Server.fetchServer(withId: id), mapping: { XcodeServer.Server($0) }).first else {
            throw XcodeServerError.serverNotFound(id)
        }
        
        return server
    }
}

extension PersistentContainer: BotQueryable {
    public func bots() async throws -> [XcodeServer.Bot] {
        try viewContext.fetchSynchronously(Bot.fetchBots(), mapping: { XcodeServer.Bot($0) })
    }
    
    public func bots(forServer id: XcodeServer.Server.ID) async throws -> [XcodeServer.Bot] {
        try viewContext.fetchSynchronously(Bot.fetchBots(forServer: id), mapping: { XcodeServer.Bot($0) })
    }
    
    public func bot(withId id: XcodeServer.Bot.ID) async throws -> XcodeServer.Bot {
        guard let bot = try viewContext.fetchSynchronously(Bot.fetchBot(withId: id), mapping: { XcodeServer.Bot($0) }).first else {
            throw XcodeServerError.botNotFound(id)
        }
        
        return bot
    }
    
    public func stats(forBot id: XcodeServer.Bot.ID) async throws -> XcodeServer.Bot.Stats {
        guard let stats = try viewContext.fetchSynchronously(Stats.fetchStats(forBot: id), mapping: { XcodeServer.Bot.Stats($0) }).first else {
            throw XcodeServerError.undefinedError(nil)
        }
        
        return stats
    }
}

extension PersistentContainer: IntegrationQueryable {
    public func integrations() async throws -> [XcodeServer.Integration] {
        try viewContext.fetchSynchronously(Integration.fetchIntegrations(), mapping: { XcodeServer.Integration($0) })
    }
    
    public func integration(withId id: XcodeServer.Integration.ID) async throws -> XcodeServer.Integration {
        guard let integration = try viewContext.fetchSynchronously(Integration.fetchIntegration(withId: id), mapping: { XcodeServer.Integration($0) }).first else {
            throw XcodeServerError.integrationNotFound(id)
        }
        
        return integration
    }
    
    public func integrations(forBot id: XcodeServer.Bot.ID) async throws -> [XcodeServer.Integration] {
        try viewContext.fetchSynchronously(Integration.fetchIntegrations(forBot: id), mapping: { XcodeServer.Integration($0) })
    }
    
    public func commits(forIntegration id: XcodeServer.Integration.ID) async throws -> [SourceControl.Commit] {
        var results: [SourceControl.Commit] = []
        try viewContext.performSynchronously({ context in
            let blueprints = try context.fetch(RevisionBlueprint.fetchBlueprints(forIntegration: id))
            let commits = blueprints.compactMap { $0.commit }
            results = commits.map { SourceControl.Commit($0) }
        })
        return results
    }
    
    public func issues(forIntegration id: XcodeServer.Integration.ID) async throws -> XcodeServer.Integration.IssueCatalog {
        try viewContext.fetchSynchronously(
            IntegrationIssues.fetchIssues(forIntegration: id),
            mapping: { XcodeServer.Integration.IssueCatalog($0) }
        ).first ?? XcodeServer.Integration.IssueCatalog()
    }
    
    public func archive(forIntegration id: XcodeServer.Integration.ID) async throws -> Data {
        throw XcodeServerError.notImplemented
    }
}

extension PersistentContainer: SourceControlQueryable {
    public func remotes() async throws -> [SourceControl.Remote] {
        try viewContext.fetchSynchronously(Repository.fetchRemotes(), mapping: { XcodeServer.SourceControl.Remote($0) })
    }
    
    public func remote(withId id: SourceControl.Remote.ID) async throws -> SourceControl.Remote {
        guard let remote = try viewContext.fetchSynchronously(Repository.fetchRemote(withId: id), mapping: { XcodeServer.SourceControl.Remote($0) }).first else {
            throw XcodeServerError.remoteNotFound(id)
        }
        
        return remote
    }
}

extension PersistentContainer: EntityQueryable {}
#endif
