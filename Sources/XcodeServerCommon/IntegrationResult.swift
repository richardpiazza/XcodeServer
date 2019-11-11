import Foundation

/// The outcome of the `Integration`.
///
/// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
///
/// ```js
/// // Integration results
/// XCSIntegrationResultSucceeded: 'succeeded',
/// XCSIntegrationResultBuildErrors: 'build-errors',
/// XCSIntegrationResultTestFailures: 'test-failures',
/// XCSIntegrationResultWarnings: 'warnings',
/// XCSIntegrationResultAnalyzerWarnings: 'analyzer-warnings',
/// XCSIntegrationResultCanceled: 'canceled',
/// XCSIntegrationResultInternalError: 'internal-error',
/// ```
public enum IntegrationResult: String, Codable {
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
    case unknown = "unknown"
    
    public var description: String {
        switch self {
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
        case .unknown: return "Unknown"
        }
    }
}
