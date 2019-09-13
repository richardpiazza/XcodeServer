import Foundation

/// ### TriggerPhase
/// When a trigger may be executed during the `Integration` lifecycle.
public enum TriggerPhase: Int16, Codable {
    case beforeIntegration = 1 // 0?
    case afterIntegration = 2
}

