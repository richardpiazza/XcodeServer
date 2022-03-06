import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import XcodeServerUtility
import XcodeServerCoreData
import CoreDataPlus
import Logging
#if canImport(CoreData)

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class Sync: AsyncParsableCommand, Route, Stored, Logged {
    
    private static let logger: Logger = Logger(label: "Sync")
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "sync",
            abstract: "Syncs data to a local Core Data store.",
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
    
    @Option(help: "The model version to use. [1.0.0].")
    var model: Model?
    
    @Flag(help: "Removes any store files prior to syncing.")
    var purge: Bool = false
    
    @Option(help: "The minimum output log level.")
    var logLevel: Logger.Level = .notice
    
    func validate() throws {
        try validateServer()
    }
    
    func run() async throws {
        ConsoleLogger.bootstrap(minimumLogLevel: logLevel)
        
        if purge {
            try storeURL.destroy()
        }
        
        let _model = model ?? Model.current
        let store = try CoreDataStore(model: _model, persistence: .store(storeURL))
        
        let asyncManager = AsyncManager(store: store) { fqdn in
            guard let username = self.username, let password = self.password else {
                return nil
            }
            
            return (username, password)
        }
        
        try await asyncManager.createServer(server)
        Self.logger.notice("Syncing SERVER [\(server)]")
        let start = Date()
        try await asyncManager.syncServer(server, deepSync: true)
        let end = Date()
        Self.logger.notice("Syncing Complete", metadata: [
            "Seconds": .string("\(end.timeIntervalSince(start))"),
            "StoreURL": .string(storeURL.rawValue.path)
        ])
        try store.cleanup()
    }
}

extension Model: ExpressibleByArgument {
}
#endif
