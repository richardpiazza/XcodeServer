import ArgumentParser
import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class Store: AsyncParsableCommand {
    
    static var configuration: CommandConfiguration = {
        .init(
            commandName: "store",
            abstract: "Interact with the Core Data persistence store.",
            usage: nil,
            discussion: "",
            version: "0.1",
            shouldDisplay: true,
            subcommands: [
                StoreInfo.self,
                StoreSync.self,
                StoreDeleteServer.self,
                StorePurge.self,
            ],
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
}

#endif
