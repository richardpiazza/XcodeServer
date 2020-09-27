public extension Integration {
    
    /// Current state of the `Integration` as it moves through the lifecycle.
    ///
    /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
    ///
    /// ```js
    /// // Integration step types
    /// XCSIntegrationStepTypePending: 'pending',
    /// XCSIntegrationStepTypePreparing: 'preparing',
    /// XCSIntegrationStepTypeCheckout: 'checkout',
    /// XCSIntegrationStepTypeTriggers: 'triggers',
    /// XCSIntegrationStepTypeBuilding: 'building',
    /// XCSIntegrationStepTypeProcessing: 'processing',
    /// XCSIntegrationStepTypeUploading: 'uploading',
    /// XCSIntegrationStepTypeCompleted: 'completed',
    /// ```
    enum Step: String, Codable {
        case pending = "pending"
        case preparing = "preparing"
        case checkout = "checkout"
        case beforeTriggers = "before-triggers"
        case triggers = "triggers"
        case building = "building"
        case testing = "testing"
        case archiving = "archiving"
        case processing = "processing"
        case uploading = "uploading"
        case completed = "completed"
    }
}

extension Integration.Step: CustomStringConvertible {
    public var description: String {
        switch self {
        case .pending: return "Pending"
        case .preparing: return "Preparing"
        case .checkout: return "Checkout"
        case .beforeTriggers: return "Before Triggers"
        case .triggers: return "Triggers"
        case .building: return "Building"
        case .testing: return "Testing"
        case .archiving: return "Archiving"
        case .processing: return "Processing"
        case .uploading: return "Uploading"
        case .completed: return "Completed"
        }
    }
}

@available(*, deprecated, renamed: "Integration.Step")
public typealias IntegrationStep = Integration.Step
