import Foundation

/// Schedule for issuing report emails.
///
/// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
///
/// ```js
/// // Email Report Schedules
/// XCSReportScheduleDaily: 0,
/// XCSReportScheduleWeekly: 1,
/// XCSReportScheduleIntegration: 2
/// ```
public enum ReportSchedule: Int16, Codable {
    case daily = 0
    case weekly = 1
    case integration = 2
}
