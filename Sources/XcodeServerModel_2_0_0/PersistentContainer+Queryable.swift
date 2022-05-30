import XcodeServer
#if canImport(CoreData)
import CoreData
import CoreDataPlus

extension PersistentContainer: ServerQueryable {
    public func servers() async throws -> [Server] {
        try viewContext.fetchSynchronously(ManagedServer.fetchServers(), mapping: { Server($0) })
    }
    
    public func server(withId id: Server.ID) async throws -> Server {
        guard let server = try viewContext.fetchSynchronously(ManagedServer.fetchServer(withId: id), mapping: { Server($0) }).first else {
            throw XcodeServerError.serverNotFound(id)
        }
        
        return server
    }
}

extension PersistentContainer: BotQueryable {
    public func bots() async throws -> [Bot] {
        try viewContext.fetchSynchronously(ManagedBot.fetchBots(), mapping: { Bot($0) })
    }
    
    public func bots(forServer id: Server.ID) async throws -> [Bot] {
        try viewContext.fetchSynchronously(ManagedBot.fetchBots(forServer: id), mapping: { Bot($0) })
    }
    
    public func bot(withId id: Bot.ID) async throws -> Bot {
        guard let bot = try viewContext.fetchSynchronously(ManagedBot.fetchBot(withId: id), mapping: { Bot($0) }).first else {
            throw XcodeServerError.botNotFound(id)
        }
        
        return bot
    }
    
    public func stats(forBot id: Bot.ID) async throws -> Bot.Stats {
        guard let stats = try viewContext.fetchSynchronously(ManagedStats.fetchStats(forBot: id), mapping: { Bot.Stats($0) }).first else {
            throw XcodeServerError.undefinedError(nil)
        }
        
        return stats
    }
}

extension PersistentContainer: IntegrationQueryable {
    public func integrations() async throws -> [Integration] {
        try viewContext.fetchSynchronously(ManagedIntegration.fetchIntegrations(), mapping: { Integration($0) })
    }
    
    public func integration(withId id: Integration.ID) async throws -> Integration {
        guard let integration = try viewContext.fetchSynchronously(ManagedIntegration.fetchIntegration(withId: id), mapping: { Integration($0) }).first else {
            throw XcodeServerError.integrationNotFound(id)
        }
        
        return integration
    }
    
    public func integrations(forBot id: Bot.ID) async throws -> [Integration] {
        try viewContext.fetchSynchronously(ManagedIntegration.fetchIntegrations(forBot: id), mapping: { Integration($0) })
    }
    
    public func commits(forIntegration id: Integration.ID) async throws -> [SourceControl.Commit] {
        var results: [SourceControl.Commit] = []
        try viewContext.performSynchronously({ context in
            let blueprints = try context.fetch(ManagedRevisionBlueprint.fetchBlueprints(forIntegration: id))
            let commits = blueprints.compactMap { $0.commit }
            results = commits.map { SourceControl.Commit($0) }
        })
        return results
    }
    
    public func issues(forIntegration id: Integration.ID) async throws -> Integration.IssueCatalog {
        try viewContext.fetchSynchronously(
            ManagedIntegrationIssues.fetchIssues(forIntegration: id),
            mapping: { Integration.IssueCatalog($0) }
        ).first ?? Integration.IssueCatalog()
    }
    
    public func archive(forIntegration id: Integration.ID) async throws -> Data {
        throw XcodeServerError.notImplemented
    }
}

extension PersistentContainer: SourceControlQueryable {
    public func remotes() async throws -> [SourceControl.Remote] {
        try viewContext.fetchSynchronously(ManagedRepository.fetchRemotes(), mapping: { SourceControl.Remote($0) })
    }
    
    public func remote(withId id: SourceControl.Remote.ID) async throws -> SourceControl.Remote {
        guard let remote = try viewContext.fetchSynchronously(ManagedRepository.fetchRemote(withId: id), mapping: { SourceControl.Remote($0) }).first else {
            throw XcodeServerError.remoteNotFound(id)
        }
        
        return remote
    }
}

extension PersistentContainer: EntityQueryable {}
#endif
