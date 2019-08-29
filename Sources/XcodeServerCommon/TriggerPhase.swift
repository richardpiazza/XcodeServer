import Foundation

/// ### TriggerPhase
/// When a trigger may be executed during the `Integration` lifecycle.
public enum TriggerPhase: Int {
    case beforeIntegration = 0
    case afterIntegration
}

