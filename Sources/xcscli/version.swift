import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import SessionPlus

final class Version: ParsableCommand {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "version",
            abstract: "Xcode Server version information",
            discussion: "",
            version: "",
            shouldDisplay: true,
            subcommands: [],
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
    
    @Argument(help: "The host name of the Xcode Server.")
    var host: String
    
    @Option(help: "User credential for the Xcode Server. (Optional)")
    var username: String?
    
    @Option(help: "Password credential for the Xcode Server. (Optional)")
    var password: String?
    
    func validate() throws {
        guard !host.isEmpty else {
            throw ValidationError("Host not provided or empty.")
        }
        
        guard let _ = URL(string: host) else {
            throw ValidationError("Host malformed: '\(host)'")
        }
    }
    
    func run() throws {
        print("Version...")
        let client = try APIClient(fqdn: host, authorizationDelegate: self)
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

extension Version: APIClientAuthorizationDelegate {
    func authorization(for fqdn: String?) -> HTTP.Authorization? {
        guard let username = self.username else {
            return nil
        }
        
        guard let password = self.password else {
            return .basic(username: username, password: nil)
        }
        
        return .basic(username: username, password: password)
    }
}
