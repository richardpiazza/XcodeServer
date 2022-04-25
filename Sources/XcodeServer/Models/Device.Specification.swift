public extension Device {
    ///
    struct Specification: Hashable, Codable {
        public var filters: [Filter]
        public var devices: Set<Device>
        
        public init(filters: [Filter] = [], devices: Set<Device> = []) {
            self.filters = filters
            self.devices = devices
        }
    }
}
