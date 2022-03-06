public struct Trigger: Hashable, Codable {
    
    public var name: String = ""
    public var type: Category = .script
    public var phase: Phase = .beforeIntegration
    public var scriptBody: String = ""
    public var email: Email = Email()
    public var conditions: Conditions = Conditions()
    
    public init() {
    }
}
