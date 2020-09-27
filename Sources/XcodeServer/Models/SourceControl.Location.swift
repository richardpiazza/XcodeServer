public extension SourceControl {
    
    /// AKA 'Branch'
    struct Location: Hashable, Identifiable {
        /// Branch Identifier
        public var id: String
        public var branchOptions: Int = 0
        public var locationType: String = ""
        public var locationRevision: String = ""
        public var remoteName: String = ""
        
        public init(id: Location.ID = "") {
            self.id = id
        }
        
        @available(*, deprecated, renamed: "id")
        public var branchIdentifier: String {
            get { id }
            set { id = newValue }
        }
    }
}
