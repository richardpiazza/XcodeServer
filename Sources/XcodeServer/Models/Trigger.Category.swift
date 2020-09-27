public extension Trigger {
    
    /// The type of trigger being executed.
    ///
    /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
    ///
    /// ```js
    /// //Trigger types
    /// XCSTriggerTypeScript: 1,
    /// XCSTriggerTypeEmail: 2,
    /// ```
    enum Category: Int, Codable {
        case script = 1
        case email = 2
    }
}

@available(*, deprecated, renamed: "Trigger.Category")
public typealias TriggerType = Trigger.Category
