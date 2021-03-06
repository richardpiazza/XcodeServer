import Foundation

/// An Xcode Server Bot integration (run).
///
/// An integration is a single run of a bot. Integrations consist of building, analyzing, testing, and archiving the
/// apps (or other software products) defined in your Xcode projects.
public struct Integration: Hashable, Identifiable {
    
    // MARK: - Metadata
    public var id: String
    public var modified: Date = Date()
    
    // MARK: - Attributes
    public var number: Int = 0
    public var step: Step = .pending
    public var shouldClean: Bool = false
    public var queued: Date?
    public var started: Date?
    public var ended: Date?
    public var duration: Double?
    public var result: Result = .unknown
    public var successStreak: Int = 0
    public var codeCoverage: Int = 0
    public var coverageDelta: Int = 0
    
    // MARK: - Relationships
    public var testHierarchy: Tests.Hierarchy?
    public var buildSummary: BuildSummary?
    public var controlledChanges: ControlledChanges?
    public var assets: AssetCatalog?
    public var issues: IssueCatalog?
    public var commits: Set<SourceControl.Commit>?
    public var revisionBlueprint: SourceControl.Blueprint?
    
    public var botId: Bot.ID?
    public var botName: String?
    public var serverId: Server.ID?
    
    public init(id: Integration.ID = "") {
        self.id = id
    }
}
