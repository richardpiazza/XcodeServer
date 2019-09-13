import Foundation

public struct XCSPlatform: Codable {
    
    enum CodingKeys: String, CodingKey {
        case buildNumber
        case displayName
        case identifier = "_id"
        case platformIdentifier = "identifier"
        case simulatorIdentifier
        case version
    }
    
    public var buildNumber: String?
    public var displayName: String?
    public var identifier: String
    public var platformIdentifier: String?
    public var simulatorIdentifier: String?
    public var version: String?
}
