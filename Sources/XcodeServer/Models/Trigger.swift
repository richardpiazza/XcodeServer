///
public struct Trigger: Hashable, Codable {
    public var name: String
    public var type: Category
    public var phase: Phase
    public var scriptBody: String
    public var email: Email
    public var conditions: Conditions
    
    public init(
        name: String = "",
        type: Trigger.Category = .script,
        phase: Trigger.Phase = .beforeIntegration,
        scriptBody: String = "",
        email: Trigger.Email = Email(),
        conditions: Trigger.Conditions = Conditions()
    ) {
        self.name = name
        self.type = type
        self.phase = phase
        self.scriptBody = scriptBody
        self.email = email
        self.conditions = conditions
    }
}
