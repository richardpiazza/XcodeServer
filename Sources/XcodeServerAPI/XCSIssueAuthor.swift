///
public struct XCSIssueAuthor: Codable {
    enum CodingKeys: String, CodingKey {
        case suspectStrategy = "XCSIssueSuspectstrategy"
        case blueprintRepository = "XCSBlueprintRepositoryID"
        case commitHash = "XCSCommitHash"
    }
    
    public var suspectStrategy: XCSSuspectStrategy?
    public var blueprintRepository: String?
    public var commitHash: String?
}

// MARK: - Equatable
extension XCSIssueAuthor: Equatable {
}

// MARK: - Hashable
extension XCSIssueAuthor: Hashable {
}
