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
    
    @Flag(help: "Displays the raw JSON response.")
    var rawResponse: Bool
    
    func validate() throws {
        try validateServer()
    }
    
    func run() throws {
        let client = try APIClient(fqdn: server, authorizationDelegate: self)
        
        if rawResponse {
            client.versions { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let value):
                    print(value.0.asPrettyJSON() ?? "OK")
                }

                Self.exit()
            }
        } else {
            client.getServer(server) { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let value):
                    let url = value.url?.appendingPathComponent("versions") ?? URL(fileURLWithPath: "")
                    terminal?.write("GET ", inColor: .cyan, bold: true)
                    terminal?.write(url.absoluteString, inColor: .yellow, bold: true)
                    terminal?.writeLine(" 200", inColor: .green, bold: true)
                    terminal?.writePrefixPadded("macOS: ", length: 14, inColor: .white, bold: true)
                    terminal?.writeLine(value.version.macOSVersion, inColor: .white, bold: false)
                    terminal?.writePrefixPadded("Xcode.app: ", length: 14, inColor: .white, bold: true)
                    terminal?.writeLine(value.version.xcodeAppVersion, inColor: .white, bold: false)
                    terminal?.writePrefixPadded("Xcode Server: ", length: 14, inColor: .white, bold: true)
                    terminal?.writeLine(value.version.app.rawValue, inColor: .white, bold: false)
                    terminal?.writePrefixPadded("API Version: ", length: 14, inColor: .white, bold: true)
                    terminal?.writeLine("\(value.version.api.rawValue)", inColor: .white, bold: false)
                }
                
                Self.exit()
            }
        }
        
        dispatchMain()
    }
}
