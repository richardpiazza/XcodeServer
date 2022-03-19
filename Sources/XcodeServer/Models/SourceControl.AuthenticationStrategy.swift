public extension SourceControl {
    ///
    struct AuthenticationStrategy: Hashable, Codable {
        public var type: String
        
        public init(type: String = "") {
            self.type = type
        }
    }
}
