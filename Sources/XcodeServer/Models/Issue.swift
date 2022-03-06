import Foundation

///
public struct Issue: Hashable, Identifiable, Codable {
    
    // MARK: - Metadata
    public var id: String
    
    // MARK: - Attributes
    public var age: Int = 0
    public var documentFilePath: String = ""
    public var documentLocationData: String = ""
    public var fixItType: String = ""
    public var lineNumber: Int = 0
    public var message: String = ""
    public var status: Status = .new
    public var target: String = ""
    public var testCase: String = ""
    public var type: Category = .unknown
    /// Additional type categorization data. For instance _'Swift Compiler Error'_.
    ///
    /// - note: Represented by 'issueType' in the API.
    public var extendedType: String = ""
    
    // MARK: - Relationships
    public var integrationId: Integration.ID?
    public var authors: [Author] = []
    public var commits: Set<SourceControl.Commit> = []
    
    public init(id: Issue.ID = "") {
        self.id = id
    }
}
