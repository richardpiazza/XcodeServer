import Foundation

// TODO: Verify Order
public enum CodeCoveragePreference: Int, Codable {
    case disabled = 0
    case enabled = 1
    case useSchemeSetting = 2
}
