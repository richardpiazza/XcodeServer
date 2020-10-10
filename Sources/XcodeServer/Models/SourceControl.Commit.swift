import Foundation

public extension SourceControl {
    
    struct Commit: Hashable, Identifiable {
        
        // MARK: - Attributes
        /// Commit Hash
        public var id: String
        public var message: String = ""
        public var date: Date = Date()
        public var isMerge: String = ""
        
        // MARK: - Relationships
        public var remoteId: SourceControl.Remote.ID?
        public var integrationId: Integration.ID?
        public var contributor: Contributor = Contributor()
        public var changes: [Change] = []
        
        public init(id: Commit.ID = "") {
            self.id = id
        }
        
        @available(*, deprecated, renamed: "id")
        public var commitHash: String {
            get { id }
            set { id = newValue }
        }
    }
}
