public extension Device {
    ///
    struct Platform: Hashable, Identifiable, Codable {
        public var id: String
        public var buildNumber: String
        public var displayName: String
        public var platformIdentifier: String
        public var simulatorIdentifier: String
        public var version: String
        
        public init(
            id: Platform.ID = "",
            buildNumber: String = "",
            displayName: String = "",
            platformIdentifier: String = "",
            simulatorIdentifier: String = "",
            version: String = ""
        ) {
            self.id = id
            self.buildNumber = buildNumber
            self.displayName = displayName
            self.platformIdentifier = platformIdentifier
            self.simulatorIdentifier = simulatorIdentifier
            self.version = version
        }
    }
}
