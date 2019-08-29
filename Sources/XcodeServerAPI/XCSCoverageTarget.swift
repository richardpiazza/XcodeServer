import Foundation

public struct XCSCoverageTarget: Codable {
    
    enum CodingKeys: String, CodingKey {
        case results = "dvcs"
        case percent = "lnp"
        case delta = "lnpd"
        case files = "fls"
        case count = "cnt"
    }
    
    public var results: [XCSCoverageResult]?
    public var files: [String : XCSCoverageFile]?
    public var percent: Double?
    public var delta: Double?
    public var count: Int?
}

