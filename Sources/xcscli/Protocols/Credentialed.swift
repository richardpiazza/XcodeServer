import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerAPI
import Logging

protocol Credentialed: CredentialDelegate {
    var username: String? { get set }
    var password: String? { get set }
}

// MARK: - XCSClient CredentialDelegate
extension Credentialed {
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
