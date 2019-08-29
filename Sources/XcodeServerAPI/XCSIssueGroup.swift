import Foundation

public struct XCSIssueGroup: Codable {
    public var unresolvedIssues: [XCSIssue]
    public var freshIssues: [XCSIssue]
    public var resolvedIssues: [XCSIssue]
    public var silencedIssues: [XCSIssue]
}
