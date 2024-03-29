import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import XcodeServerCoreData
import CoreDataPlus
import Logging
#if canImport(CoreData)

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class Sync: AsyncParsableCommand, Routed, Credentialed, Stored, Logged {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "sync",
            abstract: "DEPRECATED - Syncs data to a local Core Data store.",
            usage: nil,
            discussion: "",
            version: "",
            shouldDisplay: true,
            subcommands: [],
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
    
    @Argument(help: "Fully Qualified Domain Name of the Xcode Server.")
    var server: String
    
    @Argument(help: "Persisted store path")
    var path: String?
    
    @Option(help: "Username credential for the Xcode Server. (Optional).")
    var username: String?
    
    @Option(help: "Password credential for the Xcode Server. (Optional).")
    var password: String?
    
    @Option(help: "The model version to use. [2.0.0].")
    var model: Model?
    
    @Flag(help: "Removes any store files prior to syncing.")
    var purge: Bool = false
    
    @Flag(help: "Removes Bots and Integrations that no longer exist.")
    var cascade: Bool = false
    
    @Flag(help: "Delete the specified server from the store.")
    var delete: Bool = false
    
    @Option(help: "The minimum output log level.")
    var logLevel: Logger.Level = .info
    
    func validate() throws {
        try validateServer()
    }
    
    func run() async throws {
        ConsoleLogger.bootstrap(minimumLogLevel: logLevel)
        
        if purge {
            try storeURL.destroy()
        }
        
        let _model = model ?? Model.current
        var store: CoreDataStore! = try CoreDataStore(model: _model, persistence: .store(storeURL))
        
        let start = Date()
        
        if delete {
            Logger.xcscli.notice("Removing SERVER [\(server)]")
            try await store.removeServer(withId: server)
            
            let end = Date()
            Logger.xcscli.notice("Server '\(server)' Removed", metadata: [
                "Seconds": .string("\(end.timeIntervalSince(start))"),
                "StoreURL": .string(storeURL.rawValue.path)
            ])
            
            // Cleanup
            store = nil
            
            return
        }
        
        let client = try XCSClient(fqdn: server, credentialDelegate: self)
        
        // Create Server
        let versions = try await client.versions()
        let _server = Server(id: server, version: versions, api: client.apiVersion)
        _ = try await store.persistServer(_server)
        
        // Sync
        Logger.xcscli.notice("Syncing SERVER [\(server)]")
        
        let bots: [Bot] = try await client.bots()
        let persistedBots = try await store.persistBots(bots, forServer: server, cascadeDelete: cascade)
        for bot in persistedBots {
            let stats: Bot.Stats = try await client.stats(forBot: bot.id)
            _ = try await store.persistStats(stats, forBot: bot.id)
            
            let integrations: [Integration] = try await client.integrations(forBot: bot.id)
            let persistedIntegrations = try await store.persistIntegrations(integrations, forBot: bot.id, cascadeDelete: cascade)
            for integration in persistedIntegrations {
                let issues: Integration.IssueCatalog = try await client.issues(forIntegration: integration.id)
                _ = try await store.persistIssues(issues, forIntegration: integration.id)
                
                let commits: [SourceControl.Commit] = try await client.commits(forIntegration: integration.id)
                _ = try await store.persistCommits(commits, forIntegration: integration.id)
            }
        }
        
        let end = Date()
        Logger.xcscli.notice("Syncing Complete", metadata: [
            "Seconds": .string("\(end.timeIntervalSince(start))"),
            "StoreURL": .string(storeURL.rawValue.path)
        ])
        
        // Cleanup
        store = nil
    }
}

extension Model: ExpressibleByArgument {
}
#endif
