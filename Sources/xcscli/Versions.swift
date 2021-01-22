import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI

final class Versions: ParsableCommand, Route, Logged {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "versions",
            abstract: "Xcode Server version information",
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
    
    @Option(help: "Username credential for the Xcode Server. (Optional).")
    var username: String?
    
    @Option(help: "Password credential for the Xcode Server. (Optional).")
    var password: String?
    
    @Option(help: "The minimum output log level.")
    var logLevel: InternalLog.Level = .warn
    
    func validate() throws {
        try validateServer()
    }
    
    func run() throws {
        configureLog()
        
        let client = try APIClient(fqdn: server, credentialDelegate: self)
        
        client.versions { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                print(value.0.asPrettyJSON() ?? "OK")
            }

            Self.exit()
        }
        
        dispatchMain()
    }
}
