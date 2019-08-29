import Foundation

/// The type of trigger being executed.
public enum XCSTriggerType: Int, Codable {
    case script = 1
    case email = 2
}
