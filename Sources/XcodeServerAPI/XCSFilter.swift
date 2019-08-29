import Foundation

public struct XCSFilter: Codable {
    public var platform: XCSPlatform?
    public var filterType: Int?
    public var architectureType: Int?
}
