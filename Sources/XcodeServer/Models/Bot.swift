import Foundation

/// Represents an Xcode Server Bot.
///
/// Bots are processes that Xcode Server runs to perform integrations on the current version of a project in a source
/// code repository.
public struct Bot: Hashable, Identifiable, Codable {
    
    // MARK: - Metadata
    
    public var id: String
    public var modified: Date
    
    // MARK: - Attributes
    
    public var name: String
    public var nextIntegrationNumber: Int
    public var type: Int
    public var requiresUpgrade: Bool
    
    // MARK: - Relationships
    public var serverId: Server.ID?
    public var configuration: Configuration
    public var stats: Stats
    public var integrations: Set<Integration>
    public var sourceControlBlueprint: SourceControl.Blueprint?
    public var lastRevisionBlueprint: SourceControl.Blueprint?
    
    public init(
        id: Bot.ID = "",
        modified: Date = Date(),
        name: String = "",
        nextIntegrationNumber: Int = 0,
        type: Int = 0,
        requiresUpgrade: Bool = false,
        serverId: Server.ID? = nil,
        configuration: Bot.Configuration = Configuration(),
        stats: Bot.Stats = Stats(),
        integrations: Set<Integration> = [],
        sourceControlBlueprint: SourceControl.Blueprint? = nil,
        lastRevisionBlueprint: SourceControl.Blueprint? = nil
    ) {
        self.id = id
        self.modified = modified
        self.name = name
        self.nextIntegrationNumber = nextIntegrationNumber
        self.type = type
        self.requiresUpgrade = requiresUpgrade
        self.serverId = serverId
        self.configuration = configuration
        self.stats = stats
        self.integrations = integrations
        self.sourceControlBlueprint = sourceControlBlueprint
        self.lastRevisionBlueprint = lastRevisionBlueprint
    }
}

public extension Bot {
    var lastIntegration: Integration? {
        return Array(integrations).sorted(by: { $0.number < $1.number }).last
    }
}
