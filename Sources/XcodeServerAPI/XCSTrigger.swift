/// A bot configuration automation performed before/after and integration.
public struct XCSTrigger: Codable {
    
    /// The type of trigger being executed.
    ///
    /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
    ///
    /// ```js
    /// //Trigger types
    /// XCSTriggerTypeScript: 1,
    /// XCSTriggerTypeEmail: 2,
    /// ```
    public enum TriggerType: Int, Codable {
        case script = 1
        case email = 2
    }
    
    /// When a trigger may be executed during the `Integration` lifecycle.
    ///
    /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
    ///
    /// ```js
    /// // Trigger phases
    /// XCSTriggerPhaseBeforeIntegration: 1,
    /// XCSTriggerPhaseAfterIntegration: 2,
    /// ```
    public enum TriggerPhase: Int, Codable {
        case beforeIntegration = 1
        case afterIntegration = 2
    }
    
    public var name: String?
    public var type: TriggerType?
    public var phase: TriggerPhase?
    public var scriptBody: String?
    public var emailConfiguration: XCSEmailConfiguration?
    public var conditions: XCSConditions?
}

// MARK: - Equatable
extension XCSTrigger: Equatable {
}

// MARK: - Hashable
extension XCSTrigger: Hashable {
}
