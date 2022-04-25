import Foundation

///
public struct Issue: Hashable, Identifiable, Codable {
    // MARK: - Metadata
    public var id: String
    
    // MARK: - Attributes
    public var age: Int
    public var documentFilePath: String
    public var documentLocationData: String
    public var fixItType: String
    public var lineNumber: Int
    public var message: String
    public var status: Status
    public var target: String
    public var testCase: String
    public var type: Category
    /// Additional type categorization data. For instance _'Swift Compiler Error'_.
    ///
    /// - note: Represented by 'issueType' in the API.
    public var extendedType: String
    
    // MARK: - Relationships
    public var integrationId: Integration.ID?
    public var authors: [Author]
    public var commits: Set<SourceControl.Commit>
    
    public init(
        id: Issue.ID = "",
        age: Int = 0,
        documentFilePath: String = "",
        documentLocationData: String = "",
        fixItType: String = "",
        lineNumber: Int = 0,
        message: String = "",
        status: Issue.Status = .new,
        target: String = "",
        testCase: String = "",
        type: Issue.Category = .unknown,
        extendedType: String = "",
        integrationId: Integration.ID? = nil,
        authors: [Issue.Author] = [],
        commits: Set<SourceControl.Commit> = []
    ) {
        self.id = id
        self.age = age
        self.documentFilePath = documentFilePath
        self.documentLocationData = documentLocationData
        self.fixItType = fixItType
        self.lineNumber = lineNumber
        self.message = message
        self.status = status
        self.target = target
        self.testCase = testCase
        self.type = type
        self.extendedType = extendedType
        self.integrationId = integrationId
        self.authors = authors
        self.commits = commits
    }
}
