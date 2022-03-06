public extension Device {
    ///
    struct Platform: Hashable, Identifiable, Codable {
        public var id: String
        public var buildNumber: String = ""
        public var displayName: String = ""
        public var platformIdentifier: String = ""
        public var simulatorIdentifier: String = ""
        public var version: String = ""
        
        public init(id: Platform.ID = "") {
            self.id = id
        }
    }
}
