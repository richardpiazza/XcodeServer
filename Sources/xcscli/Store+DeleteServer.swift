import ArgumentParser
import XcodeServer
import XcodeServerCoreData
import CoreDataPlus
import Foundation
import Logging
#if canImport(CoreData)

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class StoreDeleteServer: AsyncParsableCommand, Routed, Stored, Logged {
    
    static var configuration: CommandConfiguration = {
        .init(
            commandName: "delete-server",
            abstract: "Delete a specified server from the store.",
            usage: nil,
            discussion: """
            When no 'path' is specified, the default store URL will be used:
            \(StoreURL.xcodeServer.rawValue.path)
            """,
            version: "0.1",
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
    
    @Option(help: "The model version to use. [2.0.0].")
    var model: Model?
    
    @Option(help: "The minimum output log level.")
    var logLevel: Logger.Level = .info
    
    func validate() throws {
        try validateServer()
    }
    
    func run() async throws {
        ConsoleLogger.bootstrap(minimumLogLevel: logLevel)
        
        let _model = model ?? Model.current
        var store: CoreDataStore! = try CoreDataStore(model: _model, persistence: .store(storeURL))
        
        let start = Date()
        
        Logger.xcscli.notice("Removing SERVER [\(server)]")
        try await store.removeServer(withId: server)
        
        let end = Date()
        Logger.xcscli.notice("Server '\(server)' Removed", metadata: [
            "Seconds": .string("\(end.timeIntervalSince(start))"),
            "StoreURL": .string(storeURL.rawValue.path)
        ])
        
        // Cleanup
        store = nil
    }
}

#endif
