public extension Device {

    struct Platform: Hashable, Identifiable {
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

public extension Device.Platform {
    @available(*, deprecated, renamed: "id")
    var identifier: String {
        get { id }
        set { id = newValue }
    }
}
