import Foundation

public protocol ServerPersistable {
    func persistServer(_ server: Server) async throws -> Server
    func removeServer(withId id: Server.ID) async throws
    func persistBots(_ bots: [Bot], forServer id: Server.ID) async throws -> [Bot]
}

public protocol BotPersistable {
    func persistBot(_ bot: Bot, forServer id: Server.ID) async throws -> Bot
    func removeBot(withId id: Bot.ID) async throws
    func persistStats(_ stats: Bot.Stats, forBot id: Bot.ID) async throws -> Bot.Stats
}

public protocol IntegrationPersistable {
    func persistIntegration(_ integration: Integration, forBot id: Bot.ID) async throws -> Integration
    func persistIntegrations(_ integrations: [Integration], forBot id: Bot.ID) async throws -> [Integration]
    func removeIntegration(withId id: Integration.ID) async throws
    func persistCommits(_ commits: [SourceControl.Commit], forIntegration id: Integration.ID) async throws -> [SourceControl.Commit]
    func persistIssues(_ issues: Integration.IssueCatalog, forIntegration id: Integration.ID) async throws -> Integration.IssueCatalog
    func persistArchive(_ archive: Data, forIntegration id: Integration.ID) async throws -> Data
}

public protocol SourceControlPersistable {
    func persistRemote(_ remote: SourceControl.Remote) async throws -> SourceControl.Remote
    func removeRemote(withId id: SourceControl.Remote.ID) async throws
}

/// A source that conforms to all _persistable_ types
public protocol EntityPersistable:
    BotPersistable, IntegrationPersistable, ServerPersistable, SourceControlPersistable {
}

@available(*, deprecated, renamed: "EntityPersistable")
public typealias AnyPersistable = EntityPersistable
