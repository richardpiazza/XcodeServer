import ArgumentParser
import XcodeServer
import XcodeServerCoreData
import CoreDataPlus
import Foundation
import Logging
#if canImport(CoreData)

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class StoreInfo: AsyncParsableCommand, Stored, Logged {
    
    static var configuration: CommandConfiguration = {
        .init(
            commandName: "info",
            abstract: "Displays information about the persistence store.",
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
    
    @Option(help: "The minimum output log level.")
    var logLevel: Logger.Level = .warning
    
    func run() async throws {
        print("Store URL: \(storeURL.rawValue.path)")
        if let version = try Model.versionForStore(storeURL, configurationName: .configurationName) {
            print("Model Version: \(version.rawValue)")
        }
    }
}

#endif
