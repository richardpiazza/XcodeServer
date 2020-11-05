public extension Integration {
    
    struct IssueCatalog: Hashable {
        public var buildServiceErrors: Set<Issue> = []
        public var buildServiceWarnings: Set<Issue> = []
        public var triggerErrors: Set<Issue> = []
        public var errors: IssueGroup = IssueGroup()
        public var warnings: IssueGroup = IssueGroup()
        public var testFailures: IssueGroup = IssueGroup()
        public var analyzerWarnings: IssueGroup = IssueGroup()
        
        public init() {
        }
    }
}

public extension Integration.IssueCatalog {
    var allIssues: [Issue] {
        var output: [Issue] = []
        output.append(contentsOf: buildServiceErrors)
        output.append(contentsOf: buildServiceWarnings)
        output.append(contentsOf: triggerErrors)
        output.append(contentsOf: errors.allIssues)
        output.append(contentsOf: warnings.allIssues)
        output.append(contentsOf: testFailures.allIssues)
        output.append(contentsOf: analyzerWarnings.allIssues)
        return output
    }
}
