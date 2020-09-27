public extension Device {

    struct Filter: Hashable {
        public var platform: Platform = Platform()
        public var type: Int = 0
        public var architecture: Int = 0
        
        public init() {
        }
    }
}
