import Foundation

/// Indicates how often should an Xcode Bot run.
public enum XCSBotSchedule: Int, Codable {
    case periodic = 1
    case onCommit = 2
    case manual = 3
}
