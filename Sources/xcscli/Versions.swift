import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import Logging

final class Versions: AsyncParsableCommand, Route, Logged {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "versions",
            abstract: "Xcode Server version information",
            usage: nil,
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
    var logLevel: Logger.Level = .warning
    
    func validate() throws {
        try validateServer()
    }
    
    func run() async throws {
        let client = try XCSClient(fqdn: server, credentialDelegate: self)
        let versions = try await client.versions()
        print(versions.asPrettyJSON() ?? "OK")
    }
}
