import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import SessionPlus

final class Ping: ParsableCommand {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "ping",
            abstract: "Pings the host",
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
    
    func validate() throws {
        guard !host.isEmpty else {
            throw ValidationError("Host not provided or empty.")
        }
        
        guard let _ = URL(string: host) else {
            throw ValidationError("Host malformed: '\(host)'")
        }
    }
    
    func run() throws {
        print("PING...")
        let client = try APIClient(fqdn: host, authorizationDelegate: self)
        client.ping { (result) in
            switch result {
            case .success:
                print("OK")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            Ping.exit()
        }
        
        dispatchMain()
    }
}

extension Ping: APIClientAuthorizationDelegate {
    func authorization(for fqdn: String?) -> HTTP.Authorization? {
        return nil
    }
}
