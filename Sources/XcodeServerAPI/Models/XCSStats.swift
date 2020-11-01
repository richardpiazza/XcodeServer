import Foundation

/// Statistical information about a specific bot.
public struct XCSStats: Codable {
    @available(*, deprecated, message: "Appears to no longer be available. Noted Xcode 12.1")
    public var lastCleanIntegration: XCSIntegrationSnippet?
    @available(*, deprecated, message: "Appears to no longer be available. Noted Xcode 12.1")
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

// MARK: - Equatable
extension XCSStats: Equatable {
}

// MARK: - Hashable
extension XCSStats: Hashable {
}
