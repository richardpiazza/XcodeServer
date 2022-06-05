import ArgumentParser
import XcodeServer
import XcodeServerCoreData
import CoreDataPlus
import Foundation
import Logging
#if canImport(CoreData)

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class StorePurge: AsyncParsableCommand, Stored, Logged {
    
    static var configuration: CommandConfiguration = {
        .init(
            commandName: "purge",
            abstract: "Purges the local persistence store.",
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
    
    @Argument(help: "Persisted store path")
    var path: String?
    
    @Option(help: "IGNORED - The model version to use. [2.0.0].")
    var model: Model?
    
    @Option(help: "The minimum output log level.")
    var logLevel: Logger.Level = .info
    
    func run() async throws {
        ConsoleLogger.bootstrap(minimumLogLevel: logLevel)
        
        Logger.xcscli.notice("Purging Store")
        try storeURL.destroy()
        Logger.xcscli.notice("Purge Complete")
    }
}

#endif
