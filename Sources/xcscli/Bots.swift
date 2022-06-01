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
            usage: nil,
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
    var logLevel: Logger.Level = .notice
    
    func validate() throws {
        try validateServer()
    }
    
    func run() async throws {
        ConsoleLogger.bootstrap(minimumLogLevel: logLevel)
        
        let client = try XCSClient(fqdn: server, credentialDelegate: self)
        
        do {
            switch (id) {
            case .some(let id) where path == .some(.stats):
                Logger.xcscli.notice("Retrieving Stats For Bot [\(id)]")
                let stats: Bot.Stats = try await client.stats(forBot: id)
                print(stats.asPrettyJSON() ?? "OK")
            case .some(let id) where path == .some(.integrations):
                Logger.xcscli.notice("Retrieving Integrations For Bot [\(id)]")
                let integrations: [Integration] = try await client.integrations(forBot: id)
                print(integrations.asPrettyJSON() ?? "OK")
            case .some(let id) where path == .some(.run):
                Logger.xcscli.notice("Triggering Integration For Bot [\(id)]")
                let integration = try await client.runIntegration(forBot: id)
                print(integration.asPrettyJSON() ?? "OK")
            case .some(let id) where path == .none:
                Logger.xcscli.notice("Retrieving Bot [\(id)]")
                let bot: Bot = try await client.bot(withId: id)
                print(bot.asPrettyJSON() ?? "OK")
            default:
                Logger.xcscli.notice("Retrieving Bots For Server [\(server)]")
                let bots: [Bot] = try await client.bots()
                print(bots.asPrettyJSON() ?? "OK")
            }
        } catch let xcsError as XcodeServerError {
            if case .botNotFound(let id) = xcsError {
                Logger.xcscli.error("Bot '\(id)' does not exist, or has been deleted.")
            } else {
                throw xcsError
            }
        }
    }
}
