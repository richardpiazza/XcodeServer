import Foundation

/// Type of email being sent.
public enum EmailType: Int16, Codable {
    case integrationReport = 0
    case dailyReport = 1
    case weeklyReport = 2
    case newIssueFoundEmail = 3
}
