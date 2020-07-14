///
public struct XCSIssueGroup: Codable {
    public var unresolvedIssues: [XCSIssue]
    public var freshIssues: [XCSIssue]
    public var resolvedIssues: [XCSIssue]
    public var silencedIssues: [XCSIssue]
}

// MARK: - Equatable
extension XCSIssueGroup: Equatable {
}

// MARK: - Hashable
extension XCSIssueGroup: Hashable {
}
