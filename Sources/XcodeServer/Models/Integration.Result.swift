public extension Integration {
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
    enum Result: String, Codable {
        case analyzerWarnings = "analyzer-warnings"
        case buildErrors = "build-errors"
        case buildFailed = "build-failed"
        case canceled
        case checkoutError = "checkout-error"
        case internalError = "internal-error"
        case internalBuildError = "internal-build-error"
        case internalProcessingError = "internal-processing-error"
        case succeeded = "succeeded"
        case testFailures = "test-failures"
        case triggerError = "trigger-error"
        case warnings = "warnings"
        case unknown = "unknown"
    }
}

extension Integration.Result: CustomStringConvertible {
    public var description: String {
        switch self {
        case .analyzerWarnings: return "Analyzer Warnings"
        case .buildErrors: return "Build Errors"
        case .buildFailed: return "Build Failed"
        case .canceled: return "Canceled"
        case .checkoutError: return "Checkout Error"
        case .internalError: return "Internal Error"
        case .internalBuildError: return "Internal Build Error"
        case .internalProcessingError: return "Internal Processing Error"
        case .succeeded: return "Succeeded"
        case .testFailures: return "Test Failures"
        case .triggerError: return "Trigger Error"
        case .warnings: return "Warnings"
        case .unknown: return "Unknown"
        }
    }
}
