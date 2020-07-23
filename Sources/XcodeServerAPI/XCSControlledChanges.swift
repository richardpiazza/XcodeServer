/// A tracked change to the integration environment.
public struct XCSControlledChanges: Codable {
    
    enum CodingKeys: String, CodingKey {
        case xcode
        case platforms
    }
 
    public var xcode: XCSControlledChangeTraits?
    public var platforms: XCSControlledChangePlatforms?
}

// MARK: - Equatable
extension XCSControlledChanges: Equatable {
}

// MARK: - Hashable
extension XCSControlledChanges: Hashable {
}
