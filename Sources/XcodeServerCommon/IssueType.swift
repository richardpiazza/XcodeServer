import Foundation

/// ### IssueType
/// Identifies the type of an `Integration` issue.
public enum IssueType: String {
    case unknown = "unknown"
    case buildServiceError = "buildServiceError"
    case BuildServiceWarning = "buildServiceWarning"
    case triggerError = "triggerError"
    case error = "error"
    case warning = "warning"
    case testFailure = "testFailure"
    case analyzerWarning = "analyzerWarning"
    
    public var isWarning: Bool {
        switch self {
        case .warning, .BuildServiceWarning: return true
        default: return false
        }
    }
    
    public var isError: Bool {
        switch self {
        case .triggerError, .error, .buildServiceError, .testFailure: return true
        default: return false
        }
    }
    
    public var isAnalyzerIssue: Bool {
        switch self {
        case .analyzerWarning: return true
        default: return false
        }
    }
}
