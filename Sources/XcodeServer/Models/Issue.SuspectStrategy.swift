public extension Issue {
    ///
    struct SuspectStrategy: Hashable {
        
        ///
        public enum Confidence: Int, Codable {
            case high = 0
            case low = 1
        }
        
        ///
        public enum IdentificationStrategy: Int, Codable {
            case blameLineAgainstCommits = 0
            case fileHasBeenModifiedByCommits = 1
            case blameLine = 2
            case lastCommitFromFile = 3
            case mostCommitterInFile = 4
            case singleCommitInIntegration = 5
            case multipleCommitsSingleUserInIntegration = 6
        }
        
        public var confidence: Confidence = .high
        public var reliability: Int = 0
        public var identificationStrategy: IdentificationStrategy = .blameLineAgainstCommits
        
        public init() {
        }
    }
}
