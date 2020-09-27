/// Trace information to identify the source control point where from which an issue originated.
public struct XCSIssueAuthor: Codable {
    enum CodingKeys: String, CodingKey {
        /// - note: 'strategy' is lowercased.
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
