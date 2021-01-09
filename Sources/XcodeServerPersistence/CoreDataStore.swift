import XcodeServer
import XcodeServerCoreData
import XcodeServerModel_1_0_0
import XcodeServerModel_1_1_0
import Dispatch
import Foundation
#if canImport(CoreData)
import CoreData

public class CoreDataStore {
    
    internal let container: CoreDataContainer
    
    static let assistant: ModelAssistant = {
        let models: ModelAssistant.ManagedObjectModelMaker = { model in model.managedObjectModel }
        let mappings: ModelAssistant.MappingModelMaker = { model in model.mappingModel }
        
        return ModelAssistant(managedObjectModelMaker: models, mappingModelMaker: mappings)
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
            container = try XcodeServerModel_1_0_0.Container(queue: dispatchQueue, persisted: persisted, silentFailure: silentFailure, assistant: Self.assistant)
        case .v1_1_0:
            container = try XcodeServerModel_1_1_0.Container(queue: dispatchQueue, persisted: persisted, silentFailure: silentFailure, assistant: Self.assistant)
        }
    }
    
    public var path: String? { container.path }
    
    public func unload() {
        container.unload()
    }
}

extension CoreDataStore: AnyQueryable {
    // MARK: - BotQueryable
    public func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        container.getBots(queue: queue, completion: completion)
    }
    
    public func getBots(forServer id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        container.getBots(forServer: id, queue: queue, completion: completion)
    }
    
    public func getBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        container.getBot(id, queue: queue, completion: completion)
    }
    
    public func getStatsForBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        container.getStatsForBot(id, queue: queue, completion: completion)
    }
    
    // MARK: - IntegrationQueryable
    public func getIntegrations(queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        container.getIntegrations(queue: queue, completion: completion)
    }
    
    public func getIntegrations(forBot id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        container.getIntegrations(forBot: id, queue: queue, completion: completion)
    }
    
    public func getIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        container.getIntegration(id, queue: queue, completion: completion)
    }
    
    public func getArchiveForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        container.getArchiveForIntegration(id, queue: queue, completion: completion)
    }
    
    public func getCommitsForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        container.getCommitsForIntegration(id, queue: queue, completion: completion)
    }
    
    public func getIssuesForIntegration(_ id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        container.getIssuesForIntegration(id, queue: queue, completion: completion)
    }
    
    // MARK: - ServerQueryable
    public func getServers(queue: DispatchQueue?, completion: @escaping ServersResultHandler) {
        container.getServers(queue: queue, completion: completion)
    }
    
    public func getServer(_ id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        container.getServer(id, queue: queue, completion: completion)
    }
    
    // MARK: - SourceControlQueryable
    public func getRemotes(queue: DispatchQueue?, completion: @escaping RemotesResultHandler) {
        container.getRemotes(queue: queue, completion: completion)
    }
    
    public func getRemote(_ id: SourceControl.Remote.ID, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        container.getRemote(id, queue: queue, completion: completion)
    }
}

extension CoreDataStore: AnyPersistable {
    // MARK: - BotPersistable
    public func saveBot(_ bot: XcodeServer.Bot, forServer server: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        container.saveBot(bot, forServer: server, queue: queue, completion: completion)
    }
    
    public func deleteBot(_ bot: XcodeServer.Bot, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        container.deleteBot(bot, queue: queue, completion: completion)
    }
    
    public func saveStats(_ stats: XcodeServer.Bot.Stats, forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        container.saveStats(stats, forBot: bot, queue: queue, completion: completion)
    }
    
    // MARK: - IntegrationPersistable
    public func saveIntegration(_ integration: XcodeServer.Integration, forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationResultHandler) {
        container.saveIntegration(integration, forBot: bot, queue: queue, completion: completion)
    }
    
    public func saveIntegrations(_ integrations: [XcodeServer.Integration], forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping IntegrationsResultHandler) {
        container.saveIntegrations(integrations, forBot: bot, queue: queue, completion: completion)
    }
    
    public func deleteIntegration(_ integration: XcodeServer.Integration, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        container.deleteIntegration(integration, queue: queue, completion: completion)
    }
    
    public func saveArchive(_ archive: Data, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping DataResultHandler) {
        container.saveArchive(archive, forIntegration: id, queue: queue, completion: completion)
    }
    
    public func saveCommits(_ commits: [SourceControl.Commit], forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping CommitsResultHandler) {
        container.saveCommits(commits, forIntegration: id, queue: queue, completion: completion)
    }
    
    public func saveIssues(_ issues: XcodeServer.Integration.IssueCatalog, forIntegration id: XcodeServer.Integration.ID, queue: DispatchQueue?, completion: @escaping IssueCatalogResultHandler) {
        container.saveIssues(issues, forIntegration: id, queue: queue, completion: completion)
    }
    
    // MARK: - ServerPersistable
    public func saveServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping ServerResultHandler) {
        container.saveServer(server, queue: queue, completion: completion)
    }
    
    public func saveBots(_ bots: [XcodeServer.Bot], forServer server: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        container.saveBots(bots, forServer: server, queue: queue, completion: completion)
    }
    
    public func deleteServer(_ server: XcodeServer.Server, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        container.deleteServer(server, queue: queue, completion: completion)
    }
    
    // MARK: - SourceControlPersistable
    public func saveRemote(_ remote: SourceControl.Remote, queue: DispatchQueue?, completion: @escaping RemoteResultHandler) {
        container.saveRemote(remote, queue: queue, completion: completion)
    }
    
    public func deleteRemote(_ remote: SourceControl.Remote, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        container.deleteRemote(remote, queue: queue, completion: completion)
    }
}
#endif
