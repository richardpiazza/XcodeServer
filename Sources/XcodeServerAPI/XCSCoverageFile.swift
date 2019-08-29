import Foundation

public struct XCSCoverageFile: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "tte"
        case results = "dvs"
        case percent = "lnp"
        case delta = "lnpd"
        case methods = "mth"
        case count = "cnt"
    }
    
    public var name: String?
    public var results: [XCSCoverageResult]?
    public var methods: [XCSCoverageMethod]?
    public var percent: Double?
    public var delta: Double?
    public var count: Int?
}

