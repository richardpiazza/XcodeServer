public extension Issue {
    ///
    enum IdentificationStrategy: Int, Codable {
        case blameLineAgainstCommits = 0
        case fileHasBeenModifiedByCommits = 1
        case blameLine = 2
        case lastCommitFromFile = 3
        case mostCommitterInFile = 4
        case singleCommitInIntegration = 5
        case multipleCommitsSingleUserInIntegration = 6
    }
}
