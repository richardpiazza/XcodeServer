import Foundation

public struct XCSCoverageHierarchy: Codable {
    
    public enum CodingKeys: String, CodingKey {
        case targets = "trg"
        case devices = "dvcs"
        case integrationID
        case integrationNumber
        case percent = "lnp"
        case delta = "lnpd"
    }
    
    public var targets: [String : XCSCoverageTarget]?
    public var devices: [XCSDevice]?
    public var integrationID: String?
    public var integrationNumber: Int?
    public var percent: Double?
    public var delta: Double?
}

