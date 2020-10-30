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
