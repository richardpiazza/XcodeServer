import Foundation

/// An Xcode Server Bot integration (run).
///
/// An integration is a single run of a bot. Integrations consist of building, analyzing, testing, and archiving the
/// apps (or other software products) defined in your Xcode projects.
public struct Integration: Hashable, Identifiable, Codable {
    // MARK: - Metadata
    public var id: String
    public var modified: Date
    
    // MARK: - Attributes
    public var number: Int
    public var step: Step
    public var shouldClean: Bool
    public var queued: Date?
    public var started: Date?
    public var ended: Date?
    public var duration: Double?
    public var result: Result
    public var successStreak: Int
    public var codeCoverage: Int
    public var coverageDelta: Int
    
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
    
    public init(
        id: Integration.ID = "",
        modified: Date = Date(),
        number: Int = 0,
        step: Integration.Step = .pending,
        shouldClean: Bool = false,
        queued: Date? = nil,
        started: Date? = nil,
        ended: Date? = nil,
        duration: Double? = nil,
        result: Integration.Result = .unknown,
        successStreak: Int = 0,
        codeCoverage: Int = 0,
        coverageDelta: Int = 0,
        testHierarchy: Tests.Hierarchy? = nil,
        buildSummary: Integration.BuildSummary? = nil,
        controlledChanges: Integration.ControlledChanges? = nil,
        assets: Integration.AssetCatalog? = nil,
        issues: Integration.IssueCatalog? = nil,
        commits: Set<SourceControl.Commit>? = nil,
        revisionBlueprint: SourceControl.Blueprint? = nil,
        botId: Bot.ID? = nil,
        botName: String? = nil,
        serverId: Server.ID? = nil
    ) {
        self.id = id
        self.modified = modified
        self.number = number
        self.step = step
        self.shouldClean = shouldClean
        self.queued = queued
        self.started = started
        self.ended = ended
        self.duration = duration
        self.result = result
        self.successStreak = successStreak
        self.codeCoverage = codeCoverage
        self.coverageDelta = coverageDelta
        self.testHierarchy = testHierarchy
        self.buildSummary = buildSummary
        self.controlledChanges = controlledChanges
        self.assets = assets
        self.issues = issues
        self.commits = commits
        self.revisionBlueprint = revisionBlueprint
        self.botId = botId
        self.botName = botName
        self.serverId = serverId
    }
}
