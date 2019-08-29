import Foundation

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
