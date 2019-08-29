import Foundation

/// The status of an integration issue.
public enum XCSIssueStatus: Int, Codable {
    case new = 1
    case unresolved = 2
    case resolved = 3
}

