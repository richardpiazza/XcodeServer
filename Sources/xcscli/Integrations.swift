import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import Logging

final class Integrations: AsyncParsableCommand, Routed, Credentialed, Logged {
    
    static var configuration: CommandConfiguration = {
        return CommandConfiguration(
            commandName: "integrations",
            abstract: "Interact with the `/integrations` route.",
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
        case commits
        case issues
        case coverage
        case archive
    }
    
    @Argument(help: "Fully Qualified Domain Name of the Xcode Server.")
    var server: String
    
    @Option(help: "Username credential for the Xcode Server. (Optional).")
    var username: String?
    
    @Option(help: "Password credential for the Xcode Server. (Optional).")
    var password: String?
    
    @Option(help: "Unique identifier of the Integration to request.")
    var id: String
    
    @Option(help: "Specified the additional path component for the Integration. [commits | issues | coverage | assets]")
    var path: Path?
    
    @Option(help: "The minimum output log level.")
    var logLevel: Logger.Level = .warning
    
    func validate() throws {
        try validateServer()
    }
    
    func run() async throws {
        ConsoleLogger.bootstrap(minimumLogLevel: logLevel)
        
        let client = try XCSClient(fqdn: server, credentialDelegate: self)
        
        do {
            switch (path) {
            case .some(.commits):
                Logger.xcscli.notice("Retrieving Commits For Integration [\(id)]")
                let commits: [SourceControl.Commit] = try await client.commits(forIntegration: id)
                print(commits.asPrettyJSON() ?? "OK")
            case .some(.issues):
                Logger.xcscli.notice("Retrieving Issues For Integration [\(id)]")
                let issues: Integration.IssueCatalog = try await client.issues(forIntegration: id)
                print(issues.asPrettyJSON() ?? "OK")
            case .some(.coverage):
                Logger.xcscli.notice("Retrieving Coverage For Integration [\(id)]")
                let coverage = try await client.coverage(forIntegration: id)
                print(coverage?.asPrettyJSON() ?? "OK")
            case .some(.archive):
                Logger.xcscli.notice("Retrieving Archive For Integration [\(id)]")
                let archive: (String, Data) = try await client.archive(forIntegration: id)
                print("Filename: \(archive.0)")
                let directory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
                let url = directory.appendingPathComponent(archive.0)
                try archive.1.write(to: url)
            case .none:
                if id.isEmpty {
                    Logger.xcscli.notice("Retrieving Integrations [\(server)]")
                    let integrations: [Integration] = try await client.integrations()
                    print(integrations.asPrettyJSON() ?? "OK")
                } else {
                    Logger.xcscli.notice("Retrieving Integration [\(id)]")
                    let integration: Integration = try await client.integration(withId: id)
                    print(integration.asPrettyJSON() ?? "OK")
                }
            }
        } catch let xcsError as XcodeServerError {
            if case .integrationNotFound(let id) = xcsError {
                Logger.xcscli.error("Integration '\(id)' does not exist, or has been deleted.")
            } else {
                throw xcsError
            }
        }
    }
}
