import Foundation

/// Schedule for issuing report emails.
public enum ReportSchedule: Int, Codable {
    case daily = 0
    case weekly = 1
    case integration = 2
}
