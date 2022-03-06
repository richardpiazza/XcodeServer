import XcodeServer
import Foundation

extension XCSClient: ServerQueryable {
    public func servers() async throws -> [Server] {
        [try await server(withId: fqdn)]
    }
    
    public func server(withId id: Server.ID) async throws -> Server {
        guard id == fqdn else {
            throw XcodeServerError.serverId(id)
        }
        
        let document = try await versions()
        return Server(id: fqdn, version: document, api: apiVersion)
    }
}

extension XCSClient: BotQueryable {
    public func bots() async throws -> [Bot] {
        let results: [XCSBot] = try await bots()
        return results.map { Bot($0, server: fqdn) }
    }
    
    public func bots(forServer id: Server.ID) async throws -> [Bot] {
        guard id == fqdn else {
            throw XcodeServerError.serverId(id)
        }
        
        return try await bots()
    }
    
    public func bot(withId id: Bot.ID) async throws -> Bot {
        let document: XCSBot = try await bot(withId: id)
        return Bot(document, server: fqdn)
    }
    
    public func stats(forBot id: Bot.ID) async throws -> Bot.Stats {
        let document: XCSStats = try await stats(forBot: id)
        return Bot.Stats(document)
    }
}

extension XCSClient: IntegrationQueryable {
    public func integrations() async throws -> [Integration] {
        let results: [XCSIntegration] = try await integrations()
        return results.map { Integration($0, bot: nil, server: fqdn) }
    }
    
    public func integration(withId id: Integration.ID) async throws -> Integration {
        let document: XCSIntegration = try await integration(withId: id)
        return Integration(document, bot: nil, server: fqdn)
    }
    
    public func integrations(forBot id: Bot.ID) async throws -> [Integration] {
        let results: [XCSIntegration] = try await integrations(forBot: id)
        return results.map { Integration($0, bot: id, server: fqdn) }
    }
    
    public func commits(forIntegration id: Integration.ID) async throws -> [SourceControl.Commit] {
        let results: [XCSCommit] = try await commits(forIntegration: id)
        return results.commits(forIntegration: id)
    }
    
    public func issues(forIntegration id: Integration.ID) async throws -> Integration.IssueCatalog {
        let document: XCSIssues = try await issues(forIntegration: id)
        return Integration.IssueCatalog(document, integration: id)
    }
    
    public func archive(forIntegration id: Integration.ID) async throws -> Data {
        let result: (String, Data) = try await archive(forIntegration: id)
        return result.1
    }
}

extension XCSClient: SourceControlQueryable {
    public func remotes() async throws -> [SourceControl.Remote] {
        struct NotImplemented: Swift.Error {}
        throw NotImplemented()
    }
    
    public func remote(withId id: SourceControl.Remote.ID) async throws -> SourceControl.Remote {
        struct NotImplemented: Swift.Error {}
        throw NotImplemented()
    }
}

extension XCSClient: EntityQueryable {}
