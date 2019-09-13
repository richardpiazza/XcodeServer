import Foundation

/// The type of trigger being executed.
public enum TriggerType: Int16, Codable {
    case script = 1
    case email = 2
}
