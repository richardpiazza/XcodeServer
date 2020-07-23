/// The versioning information pertaining to a controlled change.
public struct XCSControlledChangeTraits: Codable {
    
    enum CodingKeys: String, CodingKey {
        case version
        case buildNumber
    }
    
    public var version: XCSControlledChangeValues?
    public var buildNumber: XCSControlledChangeValues?
}

// MARK: - Equatable
extension XCSControlledChangeTraits: Equatable {
}

// MARK: - Hashable
extension XCSControlledChangeTraits: Hashable {
}
