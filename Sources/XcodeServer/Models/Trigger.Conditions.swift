public extension Trigger {
    
    struct Conditions: Hashable, Codable {
        public var onAllIssuesResolved: Bool = false
        public var onAnalyzerWarnings: Bool = false
        public var onBuildErrors: Bool = false
        public var onFailingTests: Bool = false
        public var onSuccess: Bool = false
        public var onWarnings: Bool = false
        public var status: Int = 0
        
        public init() {
        }
    }
}
