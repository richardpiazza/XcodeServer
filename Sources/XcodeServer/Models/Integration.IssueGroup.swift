public extension Integration {
    ///
    struct IssueGroup: Hashable, Codable {
        public var freshIssues: Set<Issue>
        public var resolvedIssues: Set<Issue>
        public var unresolvedIssues: Set<Issue>
        public var silencedIssues: Set<Issue>
        
        public init(freshIssues: Set<Issue> = [], resolvedIssues: Set<Issue> = [], unresolvedIssues: Set<Issue> = [], silencedIssues: Set<Issue> = []) {
            self.freshIssues = freshIssues
            self.resolvedIssues = resolvedIssues
            self.unresolvedIssues = unresolvedIssues
            self.silencedIssues = silencedIssues
        }
    }
}

public extension Integration.IssueGroup {
    var allIssues: [Issue] {
        var output: [Issue] = []
        output.append(contentsOf: freshIssues)
        output.append(contentsOf: resolvedIssues)
        output.append(contentsOf: unresolvedIssues)
        output.append(contentsOf: silencedIssues)
        return output
    }
}
