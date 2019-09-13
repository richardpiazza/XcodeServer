import Foundation

/// The status of an integration issue.
public enum IssueStatus: Int16, Codable {
    case new = 0
    case unresolved = 1
    case resolved = 2
}

