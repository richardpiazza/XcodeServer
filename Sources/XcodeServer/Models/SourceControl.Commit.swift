import Foundation

public extension SourceControl {
    
    struct Commit: Hashable, Identifiable {
        /// Commit Hash
        public var id: String
        public var message: String = ""
        public var date: Date = Date()
        public var isMerge: String = ""
        public var contributor: Contributor = Contributor()
        public var changes: [Change] = []
        
        public var integrationId: Integration.ID?
        
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
