import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import Logging

final class Integrations: AsyncParsableCommand, Route, Logged {
    
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
        let client = try XCSClient(fqdn: server, credentialDelegate: self)
        switch (path) {
        case .some(.commits):
            let commits: [SourceControl.Commit] = try await client.commits(forIntegration: id)
            print(commits.asPrettyJSON() ?? "OK")
        case .some(.issues):
            let issues: Integration.IssueCatalog = try await client.issues(forIntegration: id)
            print(issues.asPrettyJSON() ?? "OK")
        case .some(.coverage):
            let coverage = try await client.coverage(forIntegration: id)
            print(coverage?.asPrettyJSON() ?? "OK")
        case .some(.archive):
            let archive: (String, Data) = try await client.archive(forIntegration: id)
            print("Filename: \(archive.0)")
            let directory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
            let url = directory.appendingPathComponent(archive.0)
            try archive.1.write(to: url)
        case .none:
            if id.isEmpty {
                let integrations: [Integration] = try await client.integrations()
                print(integrations.asPrettyJSON() ?? "OK")
            } else {
                let integration: Integration = try await client.integration(withId: id)
                print(integration.asPrettyJSON() ?? "OK")
            }
        }
    }
}
