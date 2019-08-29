import Foundation

/// ### IntegrationStep
/// Current state of the `Integration` as it moves through the lifecycle.
public enum IntegrationStep: String {
    case unknown
    case pending = "pending"
    case checkout = "checkout"
    case beforeTriggers = "before-triggers"
    case building = "building"
    case testing = "testing"
    case archiving = "archiving"
    case processing = "processing"
    case uploading = "uploading"
    case completed = "completed"
    
    public var description: String {
        switch self {
        case .unknown: return "Unknown"
        case .pending: return "Pending"
        case .checkout: return "Checkout"
        case .beforeTriggers: return "Before Triggers"
        case .building: return "Building"
        case .testing: return "Testing"
        case .archiving: return "Archiving"
        case .processing: return "Processing"
        case .uploading: return "Uploading"
        case .completed: return "Completed"
        }
    }
}
