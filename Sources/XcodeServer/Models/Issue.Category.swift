public extension Issue {
    
    /// Identifies the type of an `Integration` issue.
    enum Category: String, Codable {
        case unknown = "unknown"
        case buildServiceError = "buildServiceError"
        case BuildServiceWarning = "buildServiceWarning"
        case triggerError = "triggerError"
        case error = "error"
        case warning = "warning"
        case testFailure = "testFailure"
        case analyzerWarning = "analyzerWarning"
    }
}

extension Issue.Category: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown: return "Unknown"
        case .buildServiceError: return "Build Service Error"
        case .BuildServiceWarning: return "Build Service Warning"
        case .triggerError: return "Trigger Error"
        case .error: return "Error"
        case .warning: return "Warning"
        case .testFailure: return "Test Failure"
        case .analyzerWarning: return "Analyzer Warning"
        }
    }
}

public extension Issue.Category {
    var isWarning: Bool {
        switch self {
        case .warning, .BuildServiceWarning: return true
        default: return false
        }
    }
    
    var isError: Bool {
        switch self {
        case .triggerError, .error, .buildServiceError, .testFailure: return true
        default: return false
        }
    }
    
    var isAnalyzerIssue: Bool {
        switch self {
        case .analyzerWarning: return true
        default: return false
        }
    }
}

@available(*, deprecated, renamed: "Issue.Category")
public typealias IssueType = Issue.Category
