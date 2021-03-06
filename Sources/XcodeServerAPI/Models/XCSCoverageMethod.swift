/// Code coverage method details.
public struct XCSCoverageMethod: Codable {
    
    enum CodingKeys: String, CodingKey {
        case signature = "tte"
        case results = "dvs"
        case percent = "lnp"
        case delta = "lnpd"
    }
    
    public var signature: String?
    public var results: [XCSCoverageResult]?
    public var percent: Double?
    public var delta: Double?
}

// MARK: - Equatable
extension XCSCoverageMethod: Equatable {
}

// MARK: - Hashable
extension XCSCoverageMethod: Hashable {
}
