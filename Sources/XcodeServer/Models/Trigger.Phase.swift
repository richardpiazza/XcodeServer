public extension Trigger {
    
    /// When a trigger may be executed during the `Integration` lifecycle.
    ///
    /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
    ///
    /// ```js
    /// // Trigger phases
    /// XCSTriggerPhaseBeforeIntegration: 1,
    /// XCSTriggerPhaseAfterIntegration: 2,
    /// ```
    enum Phase: Int, Codable {
        case beforeIntegration = 1
        case afterIntegration = 2
    }
}

@available(*, deprecated, renamed: "Trigger.Phase")
public typealias TriggerPhase = Trigger.Phase
