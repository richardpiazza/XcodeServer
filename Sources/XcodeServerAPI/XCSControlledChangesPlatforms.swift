import Foundation

public struct XCSControlledChangePlatforms: Codable {
    
    enum CodingKeys: String, CodingKey {
        case tvOS
        case iOS
        case macOS
        case watchOS
    }
    
    public var tvOS: XCSControlledChangeTraits?
    public var iOS: XCSControlledChangeTraits?
    public var macOS: XCSControlledChangeTraits?
    public var watchOS: XCSControlledChangeTraits?
}
