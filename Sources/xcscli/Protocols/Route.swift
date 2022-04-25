import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import Logging

protocol Route: CredentialDelegate {
    var server: String { get set }
    var username: String? { get set }
    var password: String? { get set }
    var logLevel: Logger.Level { get set }
}

extension Route {
    func validateServer() throws {
        guard !server.isEmpty else {
            throw ValidationError("Hostname not provided or empty.")
        }
        
        guard let _ = URL(string: server) else {
            throw ValidationError("Malformed Hostname: '\(server)'")
        }
    }
    
    // MARK: - XCSClient CredentialDelegate
    func credentials(for server: Server.ID) -> (username: String, password: String)? {
        guard let username = self.username else {
            return nil
        }
        
        guard let password = self.password else {
            return (username: username, password: "")
        }
        
        return (username: username, password: password)
    }
}
