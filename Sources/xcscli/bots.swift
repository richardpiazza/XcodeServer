import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI

final class Bots: ParsableCommand, Route {
    
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
    var logLevel: InternalLog.Level = .warn
    
    func validate() throws {
        try validateServer()
    }
    
    func run() throws {
        configureLog()
        
        let client = try APIClient(fqdn: server, credentialDelegate: self)
        switch (id) {
        case .some(let id) where path == .some(.stats):
            client.stats(forBotWithIdentifier: id) { (result) in
                switch result {
                case .success(let stats):
                    print(stats.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        case .some(let id) where path == .some(.integrations):
            client.integrations(forBotWithIdentifier: id) { (result) in
                switch result {
                case .success(let integrations):
                    print(integrations.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        case .some(let id) where path == .some(.run):
            client.runIntegration(forBotWithIdentifier: id) { (result) in
                switch result {
                case .success(let integration):
                    print(integration.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        case .some(let id) where path == .none:
            client.bot(withIdentifier: id) { (result) in
                switch result {
                case .success(let bot):
                    print(bot.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        default:
            client.bots { (result) in
                switch result {
                case .success(let bots):
                    print(bots.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        }
        
        dispatchMain()
    }
}
