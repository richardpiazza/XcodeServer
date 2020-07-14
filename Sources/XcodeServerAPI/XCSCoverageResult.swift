///
public struct XCSCoverageResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case tinyID = "dvc"
        case percent = "lnp"
        case delta = "lnpd"
    }
    
    public var tinyID: String?
    public var percent: Double?
    public var delta: Double?
}

// MARK: - Equatable
extension XCSCoverageResult: Equatable {
}

// MARK: - Hashable
extension XCSCoverageResult: Hashable {
}
