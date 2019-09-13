import Foundation

// TODO: Verify Order
public enum CleanSchedule: Int16, Codable {
    case never = 0
    case always = 1
    case daily = 2
    case weekly = 3
}
