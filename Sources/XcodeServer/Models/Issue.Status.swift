public extension Issue {
    
    /// The status of an integration issue.
    enum Status: Int, Codable {
        case new = 0
        case unresolved = 1
        case resolved = 2
    }
}

@available(*, deprecated, renamed: "Issue.Status")
public typealias IssueStatus = Issue.Status
