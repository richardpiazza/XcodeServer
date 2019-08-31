import Foundation

/// The status of an integration issue.
public enum IssueStatus: Int, Codable {
    case new = 1
    case unresolved = 2
    case resolved = 3
}

