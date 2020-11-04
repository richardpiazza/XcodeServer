public extension Issue {
    struct Author: Hashable {
        public var commitId: SourceControl.Commit.ID = ""
        public var remoteId: SourceControl.Remote.ID = ""
        public var suspectStrategy: SuspectStrategy = .init()
        
        public init() {
        }
    }
}
