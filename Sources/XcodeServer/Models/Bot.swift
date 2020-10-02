import Foundation

/// Represents an Xcode Server Bot.
///
/// Bots are processes that Xcode Server runs to perform integrations on the current version of a project in a source
/// code repository.
public struct Bot: Hashable, Identifiable {
    
    // MARK: - Metadata
    
    public var id: String
    public var modified: Date = Date()
    
    // MARK: - Attributes
    
    public var name: String = ""
    public var nextIntegrationNumber: Int = 0
    public var type: Int = 0
    public var requiresUpgrade: Bool = false
    
    // MARK: - Relationships
    public var serverId: Server.ID?
    public var configuration: Configuration = Configuration()
    public var stats: Stats = Stats()
    public var integrations: Set<Integration> = []
    public var sourceControlBlueprint: SourceControl.Blueprint?
    public var lastRevisionBlueprint: SourceControl.Blueprint?
    
    public init(id: Bot.ID = "") {
        self.id = id
    }
}

public extension Bot {
    var lastIntegration: Integration? {
        return Array(integrations).sorted(by: { $0.number < $1.number }).last
    }
}

public extension Bot {
    @available(*, deprecated, renamed: "id")
    var identifier: String {
        get { id }
        set { id = newValue }
    }
    
    @available(*, deprecated, renamed: "nextIntegrationNumber")
    var integrationCounter: Int {
        get { nextIntegrationNumber }
        set { nextIntegrationNumber = newValue }
    }
    
    @available(*, deprecated, renamed: "modified")
    var lastUpdate: Date? {
        get { modified }
        set { modified = newValue ?? Date() }
    }
}
