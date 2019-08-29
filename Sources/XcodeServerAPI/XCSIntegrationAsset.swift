import Foundation

public struct XCSIntegrationAsset: Codable {
    public var size: Int?
    public var fileName: String?
    public var allowAnonymousAccess: Bool?
    public var relativePath: String?
    public var triggerName: String?
    public var isDirectory: Bool?
}
