import Foundation

public protocol ServerPersistable {
    func persistServer(_ server: Server) async throws -> Server
    func removeServer(withId id: Server.ID) async throws
}

public protocol BotPersistable {
    func persistBot(_ bot: Bot, forServer id: Server.ID) async throws -> Bot
    /// Persists the provided `Bot` collection and associates to the `Server` with the specified `Server.ID`.
    ///
    /// - parameters:
    ///   - bots: The `Bot` collection that needs persistence (updates).
    ///   - id: The ID/FQDN of the `Server` for which to associate the provided `Bot`s.
    ///   - cascadeDelete: When enabled, the provided collection should be assumed to represent the new state and any persisted bots that are not represented
    ///                    should be deleted.
    func persistBots(_ bots: [Bot], forServer id: Server.ID, cascadeDelete: Bool) async throws -> [Bot]
    func removeBot(withId id: Bot.ID) async throws
    func persistStats(_ stats: Bot.Stats, forBot id: Bot.ID) async throws -> Bot.Stats
}

public protocol IntegrationPersistable {
    func persistIntegration(_ integration: Integration, forBot id: Bot.ID) async throws -> Integration
    /// Persists the provided `Integration` collection and associates to the `Bot` with the specified `Bot.ID`.
    ///
    /// - parameters:
    ///   - integrations: The `Integration` collection that needs persistence (updates).
    ///   - id: The ID of the `Bot` for which to associate the provided `Integration`s.
    ///   - cascadeDelete: When enabled, the provided collection should be assumed to represent the new state and any persisted integrations that are not
    ///                    represented should be deleted.
    func persistIntegrations(_ integrations: [Integration], forBot id: Bot.ID, cascadeDelete: Bool) async throws -> [Integration]
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

public extension BotPersistable {
    /// Persists the provided `Bot` collection and associates to the `Server` with the specified `Server.ID`.
    ///
    /// Convenience implementation that mirrors the previous signature, passing `false` to the `cascadeDelete` parameter.
    func persistBots(_ bots: [Bot], forServer id: Server.ID) async throws -> [Bot] {
        try await persistBots(bots, forServer: id, cascadeDelete: false)
    }
}

public extension IntegrationPersistable {
    /// Persists the provided `Integration` collection and associates to the `Bot` with the specified `Bot.ID`.
    ///
    /// Convenience implementation that mirrors the previous signature, passing `false` to the `cascadeDelete` parameter.
    func persistIntegrations(_ integrations: [Integration], forBot id: Bot.ID) async throws -> [Integration] {
        try await persistIntegrations(integrations, forBot: id, cascadeDelete: false)
    }
}
