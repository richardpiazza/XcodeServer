/// Metadata about a specific asset produced during an integration.
public struct XCSIntegrationAsset: Codable {
    public var size: Int?
    public var fileName: String?
    public var allowAnonymousAccess: Bool?
    public var relativePath: String?
    public var triggerName: String?
    public var isDirectory: Bool?
}

// MARK: - Equatable
extension XCSIntegrationAsset: Equatable {
}

// MARK: - Hashable
extension XCSIntegrationAsset: Hashable {
}
