import Foundation

/// Final result of an integration.
public enum XCSIntegrationResult: String, Codable {
    case succeeded
    case buildErrors = "build-errors"
    case testFailures = "test-failures"
    case warnings
    case analyzerWarnings = "analyzer-warnings"
    case canceled
    case internalError = "internal-error"
    case buildFailed = "build-failed"
    case checkoutError = "checkout-error"
    case internalBuildError = "internal-build-error"
    case triggerError = "trigger-error"
    case unknown
}
