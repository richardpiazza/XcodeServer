import XcodeServer
import CoreDataPlus
import XcodeServerModel_1_0_0
import XcodeServerModel_1_1_0
import XcodeServerModel_2_0_0
#if canImport(CoreData)
import CoreData

public class CoreDataStore {
    enum Catalog {
        case v1_0_0(CatalogContainer<Model, XcodeServerModel_1_0_0.PersistentContainer>)
        case v1_1_0(CatalogContainer<Model, XcodeServerModel_1_1_0.PersistentContainer>)
        case v2_0_0(CatalogContainer<Model, XcodeServerModel_2_0_0.PersistentContainer>)
        
        var persistentContainer: NSPersistentContainer {
            switch self {
            case .v1_0_0(let catalog):
                return catalog.persistentContainer
            case .v1_1_0(let catalog):
                return catalog.persistentContainer
            case .v2_0_0(let catalog):
                return catalog.persistentContainer
            }
        }
        
        func checkpoint(reopen: Bool = false) throws {
            switch self {
            case .v1_0_0(let catalog):
                try reopen ? catalog.checkpointAndContinue() : catalog.checkpointAndClose()
            case .v1_1_0(let catalog):
                try reopen ? catalog.checkpointAndContinue() : catalog.checkpointAndClose()
            case .v2_0_0(let catalog):
                try reopen ? catalog.checkpointAndContinue() : catalog.checkpointAndClose()
            }
        }
    }
    
    internal let catalog: Catalog
    public var persistentContainer: NSPersistentContainer { catalog.persistentContainer }
    public var entityQueryable: EntityQueryable { catalog.persistentContainer as! EntityQueryable }
    public var entityPersistable: EntityPersistable { catalog.persistentContainer as! EntityPersistable }
    
    /// Initializes the persistent store.
    ///
    /// - parameter model: `Model` version the store should be initialized with. (Migration if needed/able)
    /// - parameter persistence: The underlying storage mechanism used.
    /// - parameter silentFailure: When enabled, some migration errors will fall back to a clean state.
    public init(model: Model, persistence: Persistence = .xcodeServer, silentFailure: Bool = true) throws {
        switch model {
        case .v1_0_0:
            let container = try CatalogContainer<Model, XcodeServerModel_1_0_0.PersistentContainer>(version: model, persistence: persistence, name: .containerName, silentMigration: silentFailure)
            catalog = .v1_0_0(container)
        case .v1_1_0:
            let container = try CatalogContainer<Model, XcodeServerModel_1_1_0.PersistentContainer>(version: model, persistence: persistence, name: .containerName, silentMigration: silentFailure)
            catalog = .v1_1_0(container)
        case .v2_0_0:
            let container = try CatalogContainer<Model, XcodeServerModel_2_0_0.PersistentContainer>(version: model, persistence: persistence, name: .containerName, silentMigration: silentFailure)
            catalog = .v2_0_0(container)
        }
    }
    
    deinit {
        try? catalog.checkpoint()
    }
}

extension CoreDataStore: EntityQueryable {
    // MARK: - BotQueryable
    public func bots() async throws -> [Bot] {
        try await entityQueryable.bots()
    }
    
    public func bots(forServer id: Server.ID) async throws -> [Bot] {
        try await entityQueryable.bots(forServer: id)
    }
    
    public func bot(withId id: Bot.ID) async throws -> Bot {
        try await entityQueryable.bot(withId: id)
    }
    
    public func stats(forBot id: Bot.ID) async throws -> Bot.Stats {
        try await entityQueryable.stats(forBot: id)
    }
    
    // MARK: - IntegrationQueryable
    public func integrations() async throws -> [Integration] {
        try await entityQueryable.integrations()
    }
    
    public func integration(withId id: Integration.ID) async throws -> Integration {
        try await entityQueryable.integration(withId: id)
    }
    
    public func integrations(forBot id: Bot.ID) async throws -> [Integration] {
        try await entityQueryable.integrations(forBot: id)
    }
    
    public func commits(forIntegration id: Integration.ID) async throws -> [SourceControl.Commit] {
        try await entityQueryable.commits(forIntegration: id)
    }
    
    public func issues(forIntegration id: Integration.ID) async throws -> Integration.IssueCatalog {
        try await entityQueryable.issues(forIntegration: id)
    }
    
    public func archive(forIntegration id: Integration.ID) async throws -> Data {
        try await entityQueryable.archive(forIntegration: id)
    }
    
    // MARK: - ServerQueryable
    public func servers() async throws -> [Server] {
        try await entityQueryable.servers()
    }
    
    public func server(withId id: Server.ID) async throws -> Server {
        try await entityQueryable.server(withId: id)
    }
    
    // MARK: - SourceControlQueryable
    public func remotes() async throws -> [SourceControl.Remote] {
        try await entityQueryable.remotes()
    }
    
    public func remote(withId id: SourceControl.Remote.ID) async throws -> SourceControl.Remote {
        try await entityQueryable.remote(withId: id)
    }
}

extension CoreDataStore: EntityPersistable {
    // MARK: - BotPersistable
    public func persistBot(_ bot: XcodeServer.Bot, forServer id: XcodeServer.Server.ID) async throws -> XcodeServer.Bot {
        try await entityPersistable.persistBot(bot, forServer: id)
    }
    
    public func removeBot(withId id: XcodeServer.Bot.ID) async throws {
        try await entityPersistable.removeBot(withId: id)
    }
    
    public func persistStats(_ stats: XcodeServer.Bot.Stats, forBot id: XcodeServer.Bot.ID) async throws -> XcodeServer.Bot.Stats {
        try await entityPersistable.persistStats(stats, forBot: id)
    }
    
    // MARK: - IntegrationPersistable
    public func persistIntegration(_ integration: XcodeServer.Integration, forBot id: XcodeServer.Bot.ID) async throws -> XcodeServer.Integration {
        try await entityPersistable.persistIntegration(integration, forBot: id)
    }
    
    public func persistIntegrations(_ integrations: [XcodeServer.Integration], forBot id: XcodeServer.Bot.ID) async throws -> [XcodeServer.Integration] {
        try await entityPersistable.persistIntegrations(integrations, forBot: id)
    }
    
    public func removeIntegration(withId id: XcodeServer.Integration.ID) async throws {
        try await entityPersistable.removeIntegration(withId: id)
    }
    
    public func persistCommits(_ commits: [SourceControl.Commit], forIntegration id: XcodeServer.Integration.ID) async throws -> [SourceControl.Commit] {
        try await entityPersistable.persistCommits(commits, forIntegration: id)
    }
    
    public func persistIssues(_ issues: XcodeServer.Integration.IssueCatalog, forIntegration id: XcodeServer.Integration.ID) async throws -> XcodeServer.Integration.IssueCatalog {
        try await entityPersistable.persistIssues(issues, forIntegration: id)
    }
    
    public func persistArchive(_ archive: Data, forIntegration id: XcodeServer.Integration.ID) async throws -> Data {
        try await entityPersistable.persistArchive(archive, forIntegration: id)
    }
    
    // MARK: - ServerPersistable
    public func persistServer(_ server: Server) async throws -> Server {
        try await entityPersistable.persistServer(server)
    }
    
    public func removeServer(withId id: Server.ID) async throws {
        try await entityPersistable.removeServer(withId: id)
    }
    
    public func persistBots(_ bots: [Bot], forServer id: Server.ID) async throws -> [Bot] {
        try await entityPersistable.persistBots(bots, forServer: id)
    }
    
    // MARK: - SourceControlPersistable
    public func persistRemote(_ remote: SourceControl.Remote) async throws -> SourceControl.Remote {
        try await entityPersistable.persistRemote(remote)
    }
    
    public func removeRemote(withId id: SourceControl.Remote.ID) async throws {
        try await entityPersistable.removeRemote(withId: id)
    }
}
#endif
