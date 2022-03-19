import Foundation

public extension SourceControl {
    ///
    struct Commit: Hashable, Identifiable, Codable {
        // MARK: - Attributes
        /// Commit Hash
        public var id: String
        public var message: String
        public var date: Date
        public var isMerge: String
        
        // MARK: - Relationships
        public var remoteId: SourceControl.Remote.ID?
        public var integrationId: Integration.ID?
        public var contributor: Contributor
        public var changes: [Change]
        
        public init(
            id: Commit.ID = "",
            message: String = "",
            date: Date = Date(),
            isMerge: String = "",
            remoteId: SourceControl.Remote.ID? = nil,
            integrationId: Integration.ID? = nil,
            contributor: SourceControl.Contributor = Contributor(),
            changes: [SourceControl.Change] = []
        ) {
            self.id = id
            self.message = message
            self.date = date
            self.isMerge = isMerge
            self.remoteId = remoteId
            self.integrationId = integrationId
            self.contributor = contributor
            self.changes = changes
        }
    }
}
