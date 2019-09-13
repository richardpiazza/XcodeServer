import Foundation

/// When a trigger may be executed during the `Integration` lifecycle.
///
/// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
///
/// ```js
/// // Trigger phases
/// XCSTriggerPhaseBeforeIntegration: 1,
/// XCSTriggerPhaseAfterIntegration: 2,
/// ```
public enum TriggerPhase: Int16, Codable {
    case beforeIntegration = 1
    case afterIntegration = 2
}

