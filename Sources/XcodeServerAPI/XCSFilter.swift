///
public struct XCSFilter: Codable {
    public var platform: XCSPlatform?
    public var filterType: Int?
    public var architectureType: Int?
}

// MARK: - Equatable
extension XCSFilter: Equatable {
}

// MARK: - Hashable
extension XCSFilter: Hashable {
}
