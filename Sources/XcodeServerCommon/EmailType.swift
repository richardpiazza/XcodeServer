import Foundation

/// Type of email being sent.
///
/// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
///
/// ```js
/// // Trigger email type
/// XCSTriggerIntegrationReport: 0,
/// XCSTriggerDailyReport: 1,
/// XCSTriggerWeeklyReport: 2,
/// XCSTriggerNewIssueFoundEmail: 3,
/// ```
public enum EmailType: Int16, Codable {
    case integrationReport = 0
    case dailyReport = 1
    case weeklyReport = 2
    case newIssueFoundEmail = 3
}
