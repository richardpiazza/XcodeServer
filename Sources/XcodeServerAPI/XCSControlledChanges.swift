import Foundation

public struct XCSControlledChanges: Codable {
    
    enum CodingKeys: String, CodingKey {
        case xcode
        case platforms
    }
 
    public var xcode: XCSControlledChangeTraits?
    public var platforms: XCSControlledChangePlatforms?
}
