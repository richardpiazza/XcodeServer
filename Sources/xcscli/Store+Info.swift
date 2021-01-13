import ArgumentParser
import XcodeServer
import XcodeServerCoreData
import CoreDataPlus
import Foundation
#if canImport(CoreData)

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class StoreInfo: ParsableCommand {
    
    static var configuration: CommandConfiguration = {
        .init(
            commandName: "info",
            abstract: "Displays information about the persistence store.",
            discussion: """
            When no 'path' is specified, the default store URL will be used:
            \(CoreDataStore.defaultStoreURL.rawValue.path)
            """,
            version: "0.1",
            shouldDisplay: true,
            subcommands: [],
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
    
    @Argument(help: "File Path")
    var path: String?
    
    private var storeURL: StoreURL {
        guard let path = self.path else {
            return CoreDataStore.defaultStoreURL
        }

        return StoreURL(currentDirectory: path)
    }
    
    func run() throws {
        print("Store URL: \(storeURL.rawValue.path)")
        if let version = try Model.versionForStore(storeURL, configurationName: .configurationName) {
            print("Model Version: \(version.rawValue)")
        }
    }
}

#endif
