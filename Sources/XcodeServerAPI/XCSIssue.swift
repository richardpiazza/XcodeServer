import Foundation
import XcodeServerCommon

public struct XCSIssue: Codable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case message
        case type
        case fixItType
        case issueType
        case commits
        case testCase
        case documentFilePath
        case documentLocationData
        case lineNumber
        case integrationID
        case age
        case status
        case issueAuthors
    }
    
    public var age: Int?
    public var commits: [XCSRepositoryCommit]?
    public var documentFilePath: String?
    public var documentLocationData: String?
    public var fixItType: String?
    public var identifier: UUID
    public var integrationID: UUID?
    public var issueAuthors: [XCSIssueAuthor]?
    public var issueType: String?
    public var lineNumber: Int?
    public var message: String?
    public var status: IssueStatus?
    public var testCase: String?
    public var type: IssueType?
}
