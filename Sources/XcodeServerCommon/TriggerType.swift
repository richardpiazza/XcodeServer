import Foundation

/// The type of trigger being executed.
///
/// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
///
/// ```js
/// //Trigger types
/// XCSTriggerTypeScript: 1,
/// XCSTriggerTypeEmail: 2,
/// ```
public enum TriggerType: Int16, Codable {
    case script = 1
    case email = 2
}
