import Foundation

/// Schedule for issuing report emails.
public enum ReportSchedule: Int16, Codable {
    case daily = 0
    case weekly = 1
    case integration = 2
}
