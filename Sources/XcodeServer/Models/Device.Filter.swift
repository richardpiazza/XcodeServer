public extension Device {
    ///
    struct Filter: Hashable, Codable {
        public var platform: Platform
        public var type: Int
        public var architecture: Int
        
        public init(platform: Device.Platform = Platform(), type: Int = 0, architecture: Int = 0) {
            self.platform = platform
            self.type = type
            self.architecture = architecture
        }
    }
}
