import Foundation

///
public struct Issue: Hashable, Identifiable {
    
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
    
    // MARK: - Relationships
    public var integrationId: Integration.ID?
    public var commits: Set<SourceControl.Commit> = []
    
    public init(id: Issue.ID = "") {
        self.id = id
    }
}
