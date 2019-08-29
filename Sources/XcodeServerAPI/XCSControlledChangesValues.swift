import Foundation

public struct XCSControlledChangeValues: Codable {
    
    enum CodingKeys: String, CodingKey {
        case after
        case before
    }
    
    public var after: String?
    public var before: String?
}
