public extension Server {
    
    /// The Xcode Server API version.
    ///
    /// Identified in HTTP headers under the key '**x-xcsapiversion**'.
    enum API: Int, Codable {
        case v19 = 19
    }

    /// Xcode.app Server Version
    enum App: String, Codable {
        case v2_0 = "2.0"
    }
    
    /// Metadata about the api and applications hosted by the `Server`.
    struct Version: Hashable, Encodable {
        
        /// The **API** version.
        public var api: API = .v19
        
        /// The **Xcode Server** version.
        public var app: App = .v2_0
        
        /// The **macOS** versioning information on which the server is running.
        ///
        /// Example: _10.12 (16A201w)_
        public var macOSVersion: String = ""
        
        /// The **Xcode.app** versioning information
        ///
        /// Example: _11.5 (11E608c)_.
        public var xcodeAppVersion: String = ""
        
        /// The **Server.app** versioning information (if installed).
        ///
        /// Example: _5.1.50 (16S1083q)_.
        public var serverAppVersion: String = ""
        
        public init() {
        }
    }
}
