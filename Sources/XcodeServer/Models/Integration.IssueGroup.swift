public extension Integration {
    
    struct IssueGroup: Hashable {
        public var freshIssues: Set<Issue> = []
        public var resolvedIssues: Set<Issue> = []
        public var unresolvedIssues: Set<Issue> = []
        public var silencedIssues: Set<Issue> = []
        
        public init() {
        }
    }
}
