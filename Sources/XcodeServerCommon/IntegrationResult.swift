import Foundation

/// The outcome of the `Integration`.
public enum IntegrationResult: String, Codable {
    case unknown
    case analyzerWarnings = "analyzer-warnings"
    case buildErrors = "build-errors"
    case buildFailed = "build-failed"
    case canceled
    case checkoutError = "checkout-error"
    case internalError = "internal-error"
    case internalBuildError = "internal-build-error"
    case succeeded = "succeeded"
    case testFailures = "test-failures"
    case triggerError = "trigger-error"
    case warnings = "warnings"
    
    public var description: String {
        switch self {
        case .unknown: return "Unknown"
        case .analyzerWarnings: return "Analyer Warnings"
        case .buildErrors: return "Build Errors"
        case .buildFailed: return "Build Failed"
        case .canceled: return "Canceled"
        case .checkoutError: return "Checkout Error"
        case .internalError: return "Internal Error"
        case .internalBuildError: return "Internal Build Errors"
        case .succeeded: return "Succeeded"
        case .testFailures: return "Test Failures"
        case .triggerError: return "Trigger Error"
        case .warnings: return "Warnings"
        }
    }
}
