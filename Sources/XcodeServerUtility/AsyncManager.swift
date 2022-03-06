import Foundation
import XcodeServer
import XcodeServerAPI
import Logging

@available(*, deprecated)
public class AsyncManager {
    
    public typealias Store = EntityQueryable & EntityPersistable
    public typealias CredentialProvider = (_ fqdn: String) -> (username: String, password: String)?
    
    static let logger: Logger = Logger(label: "XcodeServer.Utility")
    
    public var credentialProvider: CredentialProvider?
    
    private let store: Store
    private var clients: [Server.ID: XCSClient] = [:]
    
    public init(store: Store, credentialProvider: CredentialProvider? = nil) {
        self.store = store
        self.credentialProvider = credentialProvider
    }
    
    private func client(_ id: Server.ID) throws -> XCSClient {
        if let client = clients[id] {
            return client
        }
        
        let client = try XCSClient(fqdn: id, credentialDelegate: self)
        clients[id] = client
        return client
    }
    
    func resetClient(_ id: Server.ID) {
        clients[id] = nil
    }
    
    public func ping(_ id: Server.ID) async throws {
        let client = try self.client(id)
        try await client.ping()
    }
    
    public func versions(_ id: Server.ID) async throws -> Server.Version {
        let client = try self.client(id)
        let response = try await client.versions()
        return Server.Version(response, api: client.apiVersion)
    }
    
    public func createServer(_ id: Server.ID) async throws {
        let server = Server(id: id)
        _ = try await store.persistServer(server)
        NotificationCenter.default.postServersDidChange()
    }
    
    public func syncServer(_ id: Server.ID, deepSync: Bool = false) async throws {
        try await syncVersions(id)
        try await syncBots(id, deepSync: deepSync)
        NotificationCenter.default.postServerDidChange(id)
    }
    
    public func syncVersions(_ id: Server.ID) async throws {
        let client = try self.client(id)
        let versions = try await client.versions()
        let server = Server(id: id, version: versions, api: client.apiVersion)
        _ = try await store.persistServer(server)
    }
    
    public func syncBots(_ id: Server.ID, deepSync: Bool = false) async throws {
        let client = try self.client(id)
        let bots: [Bot] = try await client.bots()
        let persistedBots = try await store.persistBots(bots, forServer: id)
        if deepSync {
            for bot in persistedBots {
                try await syncBot(bot, deepSync: deepSync)
            }
        }
    }
    
    public func syncBot(_ bot: Bot, deepSync: Bool = false) async throws {
        guard let id = bot.serverId else {
            throw XcodeServerError.serverNotFound("NIL")
        }
        
        let client = try self.client(id)
        try await syncStats(bot)
        let integrations: [Integration] = try await client.integrations(forBot: bot.id)
        let persistedIntegrations = try await store.persistIntegrations(integrations, forBot: bot.id)
        if deepSync {
            for integration in persistedIntegrations {
                try await syncIntegration(integration)
            }
        }
    }
    
    public func syncStats(_ bot: Bot) async throws {
        guard let id = bot.serverId else {
            throw XcodeServerError.serverNotFound("NIL")
        }
        
        let client = try self.client(id)
        let stats: Bot.Stats = try await client.stats(forBot: bot.id)
        _ = try await store.persistStats(stats, forBot: bot.id)
    }
    
    public func syncIntegration(_ integration: Integration) async throws {
        guard let serverId = integration.serverId else {
            throw XcodeServerError.serverNotFound("NIL")
        }
        
        guard let botId = integration.botId else {
            throw XcodeServerError.botNotFound("NIL")
        }
        
        let client = try self.client(serverId)
        let response: Integration = try await client.integration(withId: integration.id)
        _ = try await store.persistIntegration(response, forBot: botId)
        
        let issues: Integration.IssueCatalog = try await client.issues(forIntegration: integration.id)
        _ = try await store.persistIssues(issues, forIntegration: integration.id)
        
        let commits: [SourceControl.Commit] = try await client.commits(forIntegration: integration.id)
        _ = try await store.persistCommits(commits, forIntegration: integration.id)
    }
    
    public func syncIncompleteIntegrations() async throws {
        let servers = try await store.servers()
        let integrations = servers.flatMap { $0.incompleteIntegrations }
        for integration in integrations {
            try await syncIntegration(integration)
        }
    }
    
    public func syncIncompleteCommits() async throws {
        let servers = try await store.servers()
        let commits = servers.flatMap { $0.incompleteCommits }
        for commit in commits {
            guard let integrationId = commit.integrationId else {
                continue
            }
            
            guard let server = servers.first(where: { $0.incompleteCommits.contains(commit) }) else {
                continue
            }
            
            let client = try self.client(server.id)
            let integrationCommits: [SourceControl.Commit] = try await client.commits(forIntegration: integrationId)
            _ = try await store.persistCommits(integrationCommits, forIntegration: integrationId)
        }
    }
}

@available(*, deprecated)
extension AsyncManager: CredentialDelegate {
    public func credentials(for fqdn: String) -> (username: String, password: String)? {
        return credentialProvider?(fqdn)
    }
}

extension Server {
    var incompleteIntegrations: [Integration] {
        return bots.flatMap({ $0.incompleteIntegrations })
    }
    
    var incompleteCommits: [SourceControl.Commit] {
        return bots.flatMap({ $0.incompleteCommits })
    }
}

extension Bot {
    var incompleteIntegrations: [Integration] {
        return integrations.filter({ $0.step != .completed })
    }
    
    var incompleteCommits: [SourceControl.Commit] {
        return integrations.flatMap({ $0.incompleteCommits })
    }
}

extension Integration {
    var incompleteCommits: [SourceControl.Commit] {
        return (commits ?? []).filter({
            $0.message.isEmpty && $0.contributor.name.isEmpty
        })
    }
}
