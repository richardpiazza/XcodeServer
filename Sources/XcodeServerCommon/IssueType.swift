import Foundation

/// ### IssueType
/// Identifies the type of an `Integration` issue.
public enum IssueType: String, Codable {
    case unknown = "unknown"
    case buildServiceError = "buildServiceError"
    case buildServiceWarning = "buildServiceWarning"
    case triggerError = "triggerError"
    case error = "error"
    case warning = "warning"
    case testFailure = "testFailure"
    case analyzerWarning = "analyzerWarning"
    
    public var isWarning: Bool {
        switch self {
        case .warning, .buildServiceWarning: return true
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

// MARK: - Deprecations
public extension IssueType {
    @available(*, deprecated, renamed: "buildServiceWarning")
    static var BuildServiceWarning: IssueType {
        return .buildServiceWarning
    }
}
