/// A continuous integration agent that builds, analyzes, tests, archives, and exports your projects.
public struct XCSBot: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case configuration
        case docType = "doc_type"
        case group
        case lastRevisionBlueprint
        case name
        case nextIntegrationNumber = "integration_counter"
        case requiresUpgrade
        case sourceControlBlueprint
        case sourceControlBlueprintIdentifier
        case type
    }
    
    // MARK: - Document
    
    /// Document ID
    public var _id: String = ""
    /// Document Revision
    public var _rev: String = ""
    /// Document Type
    public var docType: String = "bot"
    
    // MARK: - Properties
    
    /// Configuration details
    public var configuration: XCSConfiguration?
    ///
    public var group: XCSGroup = XCSGroup()
    /// Last instructions on what source code to check out and how.
    public var lastRevisionBlueprint: XCSRepositoryBlueprint?
    /// Name of the bot
    public var name: String = ""
    /// The Integration Counter
    ///
    /// This number dictates the number to which the next integration will be set.
    public var nextIntegrationNumber: Int = 0
    /// Indicates if a bot needs to be upgraded to match the server?
    public var requiresUpgrade: Bool = false
    /// When present, indicates the source control configuration used for a run of the bot.
    public var sourceControlBlueprint: XCSRepositoryBlueprint?
    /// ?
    public var sourceControlBlueprintIdentifier: String = ""
    /// ?
    public var type: Int = 0
    
    public init() {
    }
}

// MARK: - Identifiable
extension XCSBot: Identifiable {
    public var id: String {
        get { _id }
        set { _id = newValue }
    }
}

// MARK: - Equatable
extension XCSBot: Equatable {
}

// MARK: - Hashable
extension XCSBot: Hashable {
}

// MARK: - Deprecations
public extension XCSBot {
    @available(*, deprecated, renamed: "id")
    var identifier: String {
        get { _id }
        set { _id = newValue }
    }
    
    @available(*, deprecated, renamed: "nextIntegrationNumber")
    var integrationCounter: Int32 {
        get { Int32(nextIntegrationNumber) }
        set { nextIntegrationNumber = Int(newValue)  }
    }
    
    @available(*, deprecated, renamed: "type")
    var typeRawValue: Int16 {
        get { Int16(type) }
        set { type = Int(newValue) }
    }
}
