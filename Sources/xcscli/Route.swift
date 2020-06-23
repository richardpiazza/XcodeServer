import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import SessionPlus

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
