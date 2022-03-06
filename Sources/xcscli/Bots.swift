import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import Logging

final class Bots: AsyncParsableCommand, Route, Logged {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "bots",
            abstract: "Interact with the `/bots` route.",
            discussion: "",
            version: "",
            shouldDisplay: true,
            subcommands: [],
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
    
    enum Path: String, ExpressibleByArgument {
        case stats
        case integrations
        case run
    }
    
    @Argument(help: "Fully Qualified Domain Name of the Xcode Server.")
    var server: String
    
    @Option(help: "Username credential for the Xcode Server. (Optional).")
    var username: String?
    
    @Option(help: "Password credential for the Xcode Server. (Optional).")
    var password: String?
    
    @Option(help: "Unique identifier of the Bot to request.")
    var id: String?
    
    @Option(help: "Specified the additional path component for the Bot. [stats | integrations | run]")
    var path: Path?
    
    @Option(help: "The minimum output log level.")
    var logLevel: Logger.Level = .warning
    
    func validate() throws {
        try validateServer()
    }
    
    func run() async throws {
        let client = try XCSClient(fqdn: server, credentialDelegate: self)
        switch (id) {
        case .some(let id) where path == .some(.stats):
            let stats: Bot.Stats = try await client.stats(forBot: id)
            print(stats.asPrettyJSON() ?? "OK")
        case .some(let id) where path == .some(.integrations):
            let integrations: [Integration] = try await client.integrations(forBot: id)
            print(integrations.asPrettyJSON() ?? "OK")
        case .some(let id) where path == .some(.run):
            let integration = try await client.runIntegration(forBot: id)
            print(integration.asPrettyJSON() ?? "OK")
        case .some(let id) where path == .none:
            let bot: Bot = try await client.bot(withId: id)
            print(bot.asPrettyJSON() ?? "OK")
        default:
            let bots: [Bot] = try await client.bots()
            print(bots.asPrettyJSON() ?? "OK")
        }
    }
}
