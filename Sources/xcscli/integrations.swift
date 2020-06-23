import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import SessionPlus

final class Integrations: ParsableCommand, Route {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "integrations",
            abstract: "Interact with the `/integrations` route.",
            discussion: "",
            version: "",
            shouldDisplay: true,
            subcommands: [],
            defaultSubcommand: nil,
            helpNames: [.short, .long]
        )
    }()
    
    enum Path: String, ExpressibleByArgument {
        case commits
        case issues
        case coverage
    }
    
    @Argument(help: "Fully Qualified Domain Name of the Xcode Server.")
    var server: String
    
    @Option(help: "Username credential for the Xcode Server. (Optional).")
    var username: String?
    
    @Option(help: "Password credential for the Xcode Server. (Optional).")
    var password: String?
    
    @Option(help: "Unique identifier of the Integration to request.")
    var id: String
    
    @Option(help: "Specified the additional path component for the Integration. [commits | issues | coverage]")
    var path: Path?
    
    func validate() throws {
        try validateServer()
    }
    
    func run() throws {
        let client = try APIClient(fqdn: server, authorizationDelegate: self)
        switch (path) {
        case .some(.commits):
            client.commits(forIntegrationWithIdentifier: id) { (result) in
                switch result {
                case .success(let commits):
                    print(commits.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        case .some(.issues):
            client.issues(forIntegrationWithIdentifier: id) { (result) in
                switch result {
                case .success(let issues):
                    print(issues.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        case .some(.coverage):
            client.coverage(forIntegrationWithIdentifier: id) { (result) in
                switch result {
                case .success(let coverage):
                    print(coverage.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        case .none:
            client.integration(withIdentifier: id) { (result) in
                switch result {
                case .success(let integration):
                    print(integration.asPrettyJSON() ?? "OK")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                Self.exit()
            }
        }
        
        dispatchMain()
    }
}
