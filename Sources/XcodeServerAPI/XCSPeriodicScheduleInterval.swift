import Foundation

/// Intervals available for a `periodic` `BotSchedule`.
public enum XCSPeriodicScheduleInterval: Int, Codable {
    case none = 0
    case hourly = 1
    case daily = 2
    case weekly = 3
    case integration = 4
}

