import Foundation

public struct XCSControlledChangeTraits: Codable {
    
    enum CodingKeys: String, CodingKey {
        case version
        case buildNumber
    }
    
    public var version: XCSControlledChangeValues?
    public var buildNumber: XCSControlledChangeValues?
}
