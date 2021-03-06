/// A file-path reference for a specific commit change.
public struct XCSCommitChangeFilePath: Codable {
    public var status: Int
    public var filePath: String
}

// MARK: - Equatable
extension XCSCommitChangeFilePath: Equatable {
}

// MARK: - Hashable
extension XCSCommitChangeFilePath: Hashable {
}
