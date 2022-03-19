public extension Integration {
    /// An `Integration` asset
    ///
    /// Each integration on your server generates a number of files, known as assets.
    /// Assets include log files, Xcode archives and installable products like IPA or PKG files.
    struct Asset: Hashable, Codable {
        public var size: Int
        public var fileName: String
        public var relativePath: String
        public var triggerName: String
        public var allowAnonymousAccess: Bool
        public var isDirectory: Bool
        
        public init(
            size: Int = 0,
            fileName: String = "",
            relativePath: String = "",
            triggerName: String = "",
            allowAnonymousAccess: Bool = false,
            isDirectory: Bool = false
        ) {
            self.size = size
            self.fileName = fileName
            self.relativePath = relativePath
            self.triggerName = triggerName
            self.allowAnonymousAccess = allowAnonymousAccess
            self.isDirectory = isDirectory
        }
    }
}
