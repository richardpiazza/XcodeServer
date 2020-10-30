public extension SourceControl {
    
    struct Change: Hashable {
        public var filePath: String = ""
        public var status: Int = 0
        
        public init() {
        }
    }
}
