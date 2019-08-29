import Foundation

public struct XCSCommit: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case docType = "doc_type"
        case tinyID
        case integration
        case botID
        case botTinyID
        case endedTimeDate
        case commits
    }
    
    public var _id: String
    public var _rev: String
    public var docType: String = "commit"
    public var tinyID: String
    public var integration: String?
    public var botID: String?
    public var botTinyID: String?
    public var endedTimeDate: [Int]?
    public var commits: [String : [XCSRepositoryCommit]]?
}
