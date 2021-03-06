/// A tracked change to the integration platforms.
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

// MARK: - Equatable
extension XCSControlledChangePlatforms: Equatable {
}

// MARK: - Hashable
extension XCSControlledChangePlatforms: Hashable {
}
