/// A collection of issues grouped by their type.
public struct XCSIssues: Codable {
    public var buildServiceErrors: [XCSIssue]?
    public var buildServiceWarnings: [XCSIssue]?
    public var triggerErrors: [XCSIssue]?
    public var errors: XCSIssueGroup?
    public var warnings: XCSIssueGroup?
    public var testFailures: XCSIssueGroup?
    public var analyzerWarnings: XCSIssueGroup?
}

// MARK: - Equatable
extension XCSIssues: Equatable {
}

// MARK: - Hashable
extension XCSIssues: Hashable {
}
