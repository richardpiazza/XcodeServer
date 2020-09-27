import Foundation
import ArgumentParser
import XcodeServerAPI

protocol Route: APIClientAuthorizationDelegate {
    var server: String { get set }
    var username: String? { get set }
    var password: String? { get set }
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
    
    // MARK: - APIClientAuthorizationDelegate
    func credentials(for fqdn: String) -> (username: String, password: String)? {
        return credentialsForServer(withFQDN: fqdn)
    }
    
    // MARK: - ManagerAuthorizationDelegate
    func credentialsForServer(withFQDN fqdn: String?) -> (username: String, password: String)? {
        guard let username = self.username else {
            return nil
        }
        
        guard let password = self.password else {
            return (username: username, password: "")
        }
        
        return (username: username, password: password)
    }
}
