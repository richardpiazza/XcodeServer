public extension Issue {
    ///
    struct Author: Hashable, Codable {
        public var commitId: SourceControl.Commit.ID
        public var remoteId: SourceControl.Remote.ID
        public var suspectStrategy: SuspectStrategy
        
        public init(commitId: SourceControl.Commit.ID = "", remoteId: SourceControl.Remote.ID = "", suspectStrategy: Issue.SuspectStrategy = .init()) {
            self.commitId = commitId
            self.remoteId = remoteId
            self.suspectStrategy = suspectStrategy
        }
    }
}
