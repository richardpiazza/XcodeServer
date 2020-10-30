/// A collection of assets produced during an integration.
public struct XCSAssets: Codable {
    ///
    public var archive: XCSIntegrationAsset?
    ///
    public var buildServiceLog: XCSIntegrationAsset?
    ///
    public var product: XCSIntegrationAsset?
    ///
    public var sourceControlLog: XCSIntegrationAsset?
    ///
    public var triggerAssets: [XCSIntegrationAsset]?
    ///
    public var xcodebuildLog: XCSIntegrationAsset?
    ///
    public var xcodebuildOutput: XCSIntegrationAsset?
}

// MARK: - Equatable
extension XCSAssets: Equatable {
}

// MARK: - Hashable
extension XCSAssets: Hashable {
}
