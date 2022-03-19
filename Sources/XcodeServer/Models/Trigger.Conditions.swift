public extension Trigger {
    ///
    struct Conditions: Hashable, Codable {
        public var onAllIssuesResolved: Bool
        public var onAnalyzerWarnings: Bool
        public var onBuildErrors: Bool
        public var onFailingTests: Bool
        public var onSuccess: Bool
        public var onWarnings: Bool
        public var status: Int
        
        public init(
            onAllIssuesResolved: Bool = false,
            onAnalyzerWarnings: Bool = false,
            onBuildErrors: Bool = false,
            onFailingTests: Bool = false,
            onSuccess: Bool = false,
            onWarnings: Bool = false,
            status: Int = 0
        ) {
            self.onAllIssuesResolved = onAllIssuesResolved
            self.onAnalyzerWarnings = onAnalyzerWarnings
            self.onBuildErrors = onBuildErrors
            self.onFailingTests = onFailingTests
            self.onSuccess = onSuccess
            self.onWarnings = onWarnings
            self.status = status
        }
    }
}
