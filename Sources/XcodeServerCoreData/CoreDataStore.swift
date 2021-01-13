import XcodeServer
import CoreDataPlus
import XcodeServerModel_1_0_0
import XcodeServerModel_1_1_0
import Dispatch
#if canImport(CoreData)
import CoreData

public class CoreDataStore {
    enum Catalog {
        case v1_0_0(CatalogContainer<Model, XcodeServerModel_1_0_0.PersistentContainer>)
        case v1_1_0(CatalogContainer<Model, XcodeServerModel_1_1_0.PersistentContainer>)
        
        var persistentContainer: NSPersistentContainer {
            switch self {
            case .v1_0_0(let catalog):
                return catalog.persistentContainer
            case .v1_1_0(let catalog):
                return catalog.persistentContainer
            }
        }
    }
    
    internal let catalog: Catalog
    
    public static var defaultStoreURL: StoreURL = {
        guard let url = try? StoreURL(applicationSupport: .configurationName, folder: .containerName) else {
            preconditionFailure()
        }
        
        return url
    }()
    
    /// Initializes the persistent store.
    ///
    /// - parameter model: `Model` version the store should be initialized with. (Migration if needed/able)
    /// - parameter dispatchQueue: DispatchQueue on which all results will be returned (when not specified).
    /// - parameter persisted: When false, this store will only be maintained in memory.
    /// - parameter silentFailure: When enabled, some migration errors will fall back to a clean state.
    public init(model: Model, dispatchQueue: DispatchQueue = .main, persisted: Bool = true, silentFailure: Bool = true) throws {
        switch model {
        case .v1_0_0:
            let persistence: CatalogContainer<Model, XcodeServerModel_1_0_0.PersistentContainer>.Persistence
            switch persisted {
            case true:
                let storeURL: StoreURL = try .init(applicationSupport: .configurationName, folder: .containerName)
                persistence = .store(storeURL)
            case false:
                persistence = .memory
            }
            let container = try CatalogContainer<Model, XcodeServerModel_1_0_0.PersistentContainer>(version: model, persistence: persistence, name: .containerName, silentMigration: silentFailure)
            catalog = .v1_0_0(container)
        case .v1_1_0:
            let persistence: CatalogContainer<Model, XcodeServerModel_1_1_0.PersistentContainer>.Persistence
            switch persisted {
            case true:
                let storeURL: StoreURL = try .init(applicationSupport: .configurationName, folder: .containerName)
                persistence = .store(storeURL)
            case false:
                persistence = .memory
            }
            let container = try CatalogContainer<Model, XcodeServerModel_1_1_0.PersistentContainer>(version: model, persistence: persistence, name: .containerName, silentMigration: silentFailure)
            catalog = .v1_1_0(container)
        }
    }
    
    public var path: String? {
        return nil
    }
}

extension CoreDataStore: AnyQueryable {
    // MARK: - BotQueryable
    public func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        (catalog.persistentContainer as! BotQueryable).getBots(queue: queue, completion: completion)
    }
    
    public func getBots(forServer id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        (catalog.persistentContainer as! BotQueryable).getBots(forServer: id, queue: queue, completion: completion)
    }
    
    public func getBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        (catalog.persistentContainer as! BotQueryable).getBot(id, queue: queue, completion: completion)
    }
    
    public func getStatsForBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        (catalog.persistentContainer as! BotQueryable).getStatsForBot(id, queue: queue, completion: completion)
    }
    
    // MARK: - IntegrationQueryable
    public func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        (catalog.persistentContainer as! IntegrationQueryable).getIntegrations(queue: queue, completion: completion)
    }
    
    public func getIntegrations(forBot id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        (catalog.persistentContainer as! IntegrationQueryable).getIntegrations(forBot: id, queue: queue, completion: completion)
    }
    
    public func getIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        (catalog.persistentContainer as! IntegrationQueryable).getIntegration(id, queue: queue, completion: completion)
    }
    
    public func getArchiveForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        (catalog.persistentContainer as! IntegrationQueryable).getArchiveForIntegration(id, queue: queue, completion: completion)
    }
    
    public func getCommitsForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        (catalog.persistentContainer as! IntegrationQueryable).getCommitsForIntegration(id, queue: queue, completion: completion)
    }
    
    public func getIssuesForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        (catalog.persistentContainer as! IntegrationQueryable).getIssuesForIntegration(id, queue: queue, completion: completion)
    }
    
    // MARK: - ServerQueryable
    public func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler) {
        (catalog.persistentContainer as! ServerQueryable).getServers(queue: queue, completion: completion)
    }
    
    public func getServer(_ id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        (catalog.persistentContainer as! ServerQueryable).getServer(id, queue: queue, completion: completion)
    }
    
    // MARK: - SourceControlQueryable
    public func getRemotes(queue: DispatchQueue?, completion: @escaping RemotesResultHandler) {
        (catalog.persistentContainer as! SourceControlQueryable).getRemotes(queue: queue, completion: completion)
    }
    
    public func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        (catalog.persistentContainer as! SourceControlQueryable).getRemote(id, queue: queue, completion: completion)
    }
}

extension CoreDataStore: AnyPersistable {
    // MARK: - BotPersistable
    public func saveBot(_ bot: XcodeServer.Bot, forServer server: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        (catalog.persistentContainer as! BotPersistable).saveBot(bot, forServer: server, queue: queue, completion: completion)
    }
    
    public func deleteBot(_ bot: XcodeServer.Bot, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        (catalog.persistentContainer as! BotPersistable).deleteBot(bot, queue: queue, completion: completion)
    }
    
    public func saveStats(_ stats: XcodeServer.Bot.Stats, forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        (catalog.persistentContainer as! BotPersistable).saveStats(stats, forBot: bot, queue: queue, completion: completion)
    }
    
    // MARK: - IntegrationPersistable
    public func saveIntegration(_ integration: XcodeServer.Integration, forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        (catalog.persistentContainer as! IntegrationPersistable).saveIntegration(integration, forBot: bot, queue: queue, completion: completion)
    }
    
    public func saveIntegrations(_ integrations: [XcodeServer.Integration], forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        (catalog.persistentContainer as! IntegrationPersistable).saveIntegrations(integrations, forBot: bot, queue: queue, completion: completion)
    }
    
    public func deleteIntegration(_ integration: XcodeServer.Integration, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        (catalog.persistentContainer as! IntegrationPersistable).deleteIntegration(integration, queue: queue, completion: completion)
    }
    
    public func saveArchive(_ archive: Data, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        (catalog.persistentContainer as! IntegrationPersistable).saveArchive(archive, forIntegration: id, queue: queue, completion: completion)
    }
    
    public func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        (catalog.persistentContainer as! IntegrationPersistable).saveCommits(commits, forIntegration: id, queue: queue, completion: completion)
    }
    
    public func saveIssues(_ issues: XcodeServer.Integration.IssueCatalog, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        (catalog.persistentContainer as! IntegrationPersistable).saveIssues(issues, forIntegration: id, queue: queue, completion: completion)
    }
    
    // MARK: - ServerPersistable
    public func saveServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        (catalog.persistentContainer as! ServerPersistable).saveServer(server, queue: queue, completion: completion)
    }
    
    public func saveBots(_ bots: [XcodeServer.Bot], forServer server: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        (catalog.persistentContainer as! ServerPersistable).saveBots(bots, forServer: server, queue: queue, completion: completion)
    }
    
    public func deleteServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        (catalog.persistentContainer as! ServerPersistable).deleteServer(server, queue: queue, completion: completion)
    }
    
    // MARK: - SourceControlPersistable
    public func saveRemote(_ remote: SourceControl.Remote, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        (catalog.persistentContainer as! SourceControlPersistable).saveRemote(remote, queue: queue, completion: completion)
    }
    
    public func deleteRemote(_ remote: SourceControl.Remote, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        (catalog.persistentContainer as! SourceControlPersistable).deleteRemote(remote, queue: queue, completion: completion)
    }
}
#endif
