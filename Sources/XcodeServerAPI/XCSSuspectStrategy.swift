///
public struct XCSSuspectStrategy: Codable {
    
    public enum IssueConfidence: Int, Codable {
        case high = 0
        case low = 1
    }
    
    public enum IssueIdentificationStrategy: Int, Codable {
        case blameLineAgainstCommits = 0
        case fileHasBeenModifiedByCommits = 1
        case blameLine = 2
        case lastCommitFromFile = 3
        case mostCommitterInFile = 4
        case singleCommitInIntegration = 5
        case multipleCommitsSingleUserInIntegration = 6
    }
    
    public var confidence: IssueConfidence?
    public var reliability: Int?
    public var identificationStrategy: IssueIdentificationStrategy?
}

// MARK: - Equatable
extension XCSSuspectStrategy: Equatable {
}

// MARK: - Hashable
extension XCSSuspectStrategy: Hashable {
}
