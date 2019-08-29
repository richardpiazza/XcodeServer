import Foundation

public struct XCSAssets: Codable {
    public var xcodebuildOutput: XCSIntegrationAsset?
    public var buildServiceLog: XCSIntegrationAsset?
    public var xcodebuildLog: XCSIntegrationAsset?
    public var sourceControlLog: XCSIntegrationAsset?
    public var triggerAssets: [XCSIntegrationAsset]?
    public var archive: XCSIntegrationAsset?
    public var product: XCSIntegrationAsset?
}
