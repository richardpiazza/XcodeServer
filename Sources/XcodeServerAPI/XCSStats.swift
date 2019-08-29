import Foundation

public struct XCSStats: Codable {
    public var lastCleanIntegration: XCSIntegrationSnippet?
    public var bestSuccessStreak: XCSIntegrationSnippet?
    public var numberOfIntegrations: Int?
    public var numberOfCommits: Int?
    public var averageIntegrationTime: XCSStatsSummary?
    public var testAdditionRate: Int?
    public var analysisWarnings: XCSStatsSummary?
    public var testFailures: XCSStatsSummary?
    public var errors: XCSStatsSummary?
    public var regressedPerfTests: XCSStatsSummary?
    public var warnings: XCSStatsSummary?
    public var improvedPerfTests: XCSStatsSummary?
    public var tests: XCSStatsSummary?
    public var codeCoveragePercentageDelta: Int?
    public var numberOfSuccessfulIntegrations: Int?
    public var sinceDate: Date?
}
