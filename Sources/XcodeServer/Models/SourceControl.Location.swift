public extension SourceControl {
    /// AKA 'Branch'
    struct Location: Hashable, Identifiable, Codable {
        /// Branch Identifier
        public var id: String
        public var branchOptions: Int
        public var locationType: String
        public var locationRevision: String
        public var remoteName: String
        
        public init(
            id: Location.ID = "",
            branchOptions: Int = 0,
            locationType: String = "",
            locationRevision: String = "",
            remoteName: String = ""
        ) {
            self.id = id
            self.branchOptions = branchOptions
            self.locationType = locationType
            self.locationRevision = locationRevision
            self.remoteName = remoteName
        }
    }
}
