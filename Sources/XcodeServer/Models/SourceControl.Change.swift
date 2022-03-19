public extension SourceControl {
    ///
    struct Change: Hashable, Codable {
        public var filePath: String
        public var status: Int
        
        public init(filePath: String = "", status: Int = 0) {
            self.filePath = filePath
            self.status = status
        }
    }
}
