public extension Issue {
    ///
    struct SuspectStrategy: Hashable, Codable {
        
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
        
        public var confidence: Confidence
        public var reliability: Int
        public var identificationStrategy: IdentificationStrategy
        
        public init(
            confidence: Issue.SuspectStrategy.Confidence = .high,
            reliability: Int = 0,
            identificationStrategy: Issue.SuspectStrategy.IdentificationStrategy = .blameLineAgainstCommits
        ) {
            self.confidence = confidence
            self.reliability = reliability
            self.identificationStrategy = identificationStrategy
        }
    }
}
