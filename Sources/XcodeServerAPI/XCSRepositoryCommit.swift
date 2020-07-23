import Foundation

/// A published set of changes to a source control repository.
public struct XCSRepositoryCommit: Codable {
    
    enum CodingKeys: String, CodingKey {
        case repositoryID = "XCSBlueprintRepositoryID"
        case commitChangeFilePaths = "XCSCommitCommitChangeFilePaths"
        case contributor = "XCSCommitContributor"
        case hash = "XCSCommitHash"
        case message = "XCSCommitMessage"
        case isMerge = "XCSCommitIsMerge"
        case timestamp = "XCSCommitTimestamp"
        case timestampDate = "XCSCommitTimestampDate"
    }
    
    public var repositoryID: String?
    public var commitChangeFilePaths: [XCSCommitChangeFilePath]?
    public var contributor: XCSCommitContributor?
    public var hash: String?
    public var message: String?
    public var isMerge: String?
    public var timestamp: Date?
    public var timestampDate: [Int]?
}

// MARK: - Equatable
extension XCSRepositoryCommit: Equatable {
}

// MARK: - Hashable
extension XCSRepositoryCommit: Hashable {
}
