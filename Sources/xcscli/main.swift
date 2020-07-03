import Foundation
import ArgumentParser

struct Command: ParsableCommand {
    
    static var configuration: CommandConfiguration = {
        
        var subcommands: [ParsableCommand.Type] = [
            Ping.self,
            Versions.self,
            Bots.self,
            Integrations.self
        ]
        
        #if canImport(CoreData)
        subcommands.append(Sync.self)
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

Command.main()
