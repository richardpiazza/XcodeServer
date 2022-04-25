public extension Integration {
    ///
    struct IssueCatalog: Hashable, Codable {
        public var buildServiceErrors: Set<Issue>
        public var buildServiceWarnings: Set<Issue>
        public var triggerErrors: Set<Issue>
        public var errors: IssueGroup
        public var warnings: IssueGroup
        public var testFailures: IssueGroup
        public var analyzerWarnings: IssueGroup
        
        public init(
            buildServiceErrors: Set<Issue> = [],
            buildServiceWarnings: Set<Issue> = [],
            triggerErrors: Set<Issue> = [],
            errors: Integration.IssueGroup = IssueGroup(),
            warnings: Integration.IssueGroup = IssueGroup(),
            testFailures: Integration.IssueGroup = IssueGroup(),
            analyzerWarnings: Integration.IssueGroup = IssueGroup()
        ) {
            self.buildServiceErrors = buildServiceErrors
            self.buildServiceWarnings = buildServiceWarnings
            self.triggerErrors = triggerErrors
            self.errors = errors
            self.warnings = warnings
            self.testFailures = testFailures
            self.analyzerWarnings = analyzerWarnings
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
