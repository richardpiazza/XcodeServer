public extension Device {
    
    struct Specification: Hashable {
        public var filters: [Filter] = []
        public var devices: Set<Device> = []
        
        public init() {
        }
    }
}
