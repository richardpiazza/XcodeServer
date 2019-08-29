import Foundation

public struct XCSVersion: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case docType = "doc_type"
        case tinyID
        case os
        case xcode
        case xcodeServer
        case server
    }
    
    public var _id: String
    public var _rev: String
    public var docType: String
    public var tinyID: String
    /// macOS version (i.e. 10.12 (16A201w))
    public var os: String?
    /// Xcode version used for builds (i.e. 8.0 (8S128d))
    public var xcode: String?
    /// The Xcode Server API version (i.e. 2.0)
    public var xcodeServer: String?
    /// The Server.app version (i.e. 5.1.50 (16S1083q))
    public var server: String?
}
