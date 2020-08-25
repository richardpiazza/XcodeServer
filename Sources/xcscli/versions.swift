import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI

final class Versions: ParsableCommand, Route {
    
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
    
    func validate() throws {
        try validateServer()
    }
    
    func run() throws {
        let client = try APIClient(fqdn: server, authorizationDelegate: self)
        client.versions { (result) in
            switch result {
            case .success(let value):
                if let json = value.0.asPrettyJSON() {
                    print(json)
                } else {
                    print("OK")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            Self.exit()
        }
        
        dispatchMain()
    }
}
