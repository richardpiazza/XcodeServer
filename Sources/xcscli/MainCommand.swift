import Foundation
import ArgumentParser
import Logging

struct MainCommand: AsyncParsableCommand {
    
    static var configuration: CommandConfiguration = {
        var subcommands: [ParsableCommand.Type] = [
            Ping.self,
            Versions.self,
            Bots.self,
            Integrations.self
        ]
        
        #if canImport(CoreData)
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            subcommands.append(Sync.self)
            subcommands.append(Store.self)
        }
        #endif
        
        return CommandConfiguration(
            commandName: "xcscli",
            abstract: "XcodeServer Framework Command Line Interface",
            discussion: "",
            version: "1.0.0",
            shouldDisplay: true,
            subcommands: subcommands,
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
}

@main enum Main: AsyncMain {
    typealias Command = MainCommand
}
