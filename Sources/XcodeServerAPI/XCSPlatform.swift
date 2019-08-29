import Foundation

public struct XCSPlatform: Codable {
    public var _id: String
    public var _rev: String
    public var displayName: String?
    public var simulatorIdentifier: String?
    public var identifier: String?
    public var buildNumber: String?
    public var version: String?
}
