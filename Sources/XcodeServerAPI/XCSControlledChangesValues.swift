/// The before & after state of a controlled change.
public struct XCSControlledChangeValues: Codable {
    
    enum CodingKeys: String, CodingKey {
        case after
        case before
    }
    
    public var after: String?
    public var before: String?
}

// MARK: - Equatable
extension XCSControlledChangeValues: Equatable {
}

// MARK: - Hashable
extension XCSControlledChangeValues: Hashable {
}
