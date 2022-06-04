import Foundation
import ArgumentParser

protocol Routed {
    var server: String { get set }
}

extension Routed {
    func validateServer() throws {
        guard !server.isEmpty else {
            throw ValidationError("Hostname not provided or empty.")
        }
        
        guard let _ = URL(string: server) else {
            throw ValidationError("Malformed Hostname: '\(server)'")
        }
    }
}
