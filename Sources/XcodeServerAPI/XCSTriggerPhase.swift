import Foundation

/// Indication of when a trigger runs.
public enum XCSTriggerPhase: Int, Codable {
    case beforeIntegration = 1
    case afterIntegration = 2
}
