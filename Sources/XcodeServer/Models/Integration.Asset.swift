public extension Integration {
    
    /// An `Integration` asset
    ///
    /// Each integration on your server generates a number of files, known as assets.
    /// Assets include log files, Xcode archives and installable products like IPA or PKG files.
    struct Asset: Hashable, Codable {
        public var size: Int = 0
        public var fileName: String = ""
        public var relativePath: String = ""
        public var triggerName: String = ""
        public var allowAnonymousAccess: Bool = false
        public var isDirectory: Bool = false
        
        public init() {
        }
    }
}
