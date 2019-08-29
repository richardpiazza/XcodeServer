import Foundation

public struct XCSBuildResultSummary: Codable {
    public var errorCount: Int = 0
    public var errorChange: Int = 0
    public var warningCount: Int = 0
    public var warningChange: Int = 0
    public var testsCount: Int = 0
    public var testsChange: Int = 0
    public var testFailureCount: Int = 0
    public var testFailureChange: Int = 0
    public var analyzerWarningCount: Int = 0
    public var analyzerWarningChange: Int = 0
    public var regressedPerfTestCount: Int = 0
    public var improvedPerfTestCount: Int = 0
    public var codeCoveragePercentage: Int = 0
    public var codeCoveragePercentageDelta: Int = 0
}
