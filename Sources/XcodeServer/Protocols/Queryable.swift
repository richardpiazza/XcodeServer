import Foundation

/// A source that allows for retrieval of `Server` entities.
public protocol ServerQueryable {
    func servers() async throws -> [Server]
    func server(withId id: Server.ID) async throws -> Server
}

/// A source that allows for retrieval of `Bot` & related entities.
public protocol BotQueryable {
    func bots() async throws -> [Bot]
    func bots(forServer id: Server.ID) async throws -> [Bot]
    func bot(withId id: Bot.ID) async throws -> Bot
    func stats(forBot id: Bot.ID) async throws -> Bot.Stats
}

/// A source that allows for retrieval of `Integration` & related entities.
public protocol IntegrationQueryable {
    func integrations() async throws -> [Integration]
    func integration(withId id: Integration.ID) async throws -> Integration
    func integrations(forBot id: Bot.ID) async throws -> [Integration]
    func commits(forIntegration id: Integration.ID) async throws -> [SourceControl.Commit]
    func issues(forIntegration id: Integration.ID) async throws -> Integration.IssueCatalog
    func archive(forIntegration id: Integration.ID) async throws -> Data
}

/// A source that allows for retrieval of `SourceControl` entities.
public protocol SourceControlQueryable {
    func remotes() async throws -> [SourceControl.Remote]
    func remote(withId id: SourceControl.Remote.ID) async throws -> SourceControl.Remote
}

/// A source that conforms to all _queryable_ protocols.
public protocol EntityQueryable:
    BotQueryable, IntegrationQueryable, ServerQueryable, SourceControlQueryable {
}

@available(*, deprecated, renamed: "EntityQueryable")
public typealias AnyQueryable = EntityQueryable
