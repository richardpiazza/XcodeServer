import Foundation

/// ### IntegrationResult
/// The outcome of the `Integration`.
public enum IntegrationResult: String {
    case unknown
    case buildErrors = "build-errors"
    case buildFailed = "build-failed"
    case checkoutError = "checkout-error"
    case internalError = "internal-error"
    case internalBuildError = "internal-build-error"
    case succeeded = "succeeded"
    case testFailures = "test-failures"
    case warnings = "warnings"
    
    public var description: String {
        switch self {
        case .unknown: return "Unknown"
        case .buildErrors: return "Build Errors"
        case .buildFailed: return "Build Failed"
        case .checkoutError: return "Checkout Error"
        case .internalError: return "Internal Error"
        case .internalBuildError: return "Internal Build Errors"
        case .succeeded: return "Succeeded"
        case .testFailures: return "Test Failures"
        case .warnings: return "Warnings"
        }
    }
}
