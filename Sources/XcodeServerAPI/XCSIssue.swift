import XcodeServerCommon

public struct XCSIssue: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
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
    
    public var _id: String
    public var age: Int?
    public var commits: [XCSRepositoryCommit]?
    public var documentFilePath: String?
    public var documentLocationData: String?
    public var fixItType: String?
    public var integrationID: String?
    public var issueAuthors: [XCSIssueAuthor]?
    public var issueType: String?
    public var lineNumber: Int?
    public var message: String?
    public var status: IssueStatus?
    public var testCase: String?
    public var type: IssueType?
}

// MARK: - Identifiable
extension XCSIssue: Identifiable {
    public var id: String {
        get { _id }
        set { _id = newValue }
    }
}

// MARK: - Equatable
extension XCSIssue: Equatable {
}

// MARK: - Hashable
extension XCSIssue: Hashable {
}

// MARK: - Deprecations
public extension XCSIssue {
    @available(*, deprecated, renamed: "id")
    var identifier: String {
        get { _id }
        set { _id = newValue }
    }
}
