import Foundation

public enum IssueIdentificationStrategy: Int16, Codable {
    case blameLineAgainstCommits = 0
    case fileHasBeenModifiedByCommits = 1
    case blameLine = 2
    case lastCommitFromFile = 3
    case mostCommitterInFile = 4
    case singleCOmmitInIntegration = 5
    case multipleCOmmitsSingleUserInIntegration = 6
}
