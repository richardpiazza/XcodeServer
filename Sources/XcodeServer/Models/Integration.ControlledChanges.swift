public extension Integration {
    ///
    struct ControlledChanges: Hashable, Codable {
        
        public struct Values: Hashable, Codable {
            public var before: String
            public var after: String
            
            public init(before: String = "", after: String = "") {
                self.before = before
                self.after = after
            }
        }
        
        public struct Traits: Hashable, Codable {
            public var version: Values
            public var buildNumber: Values
            
            public init(version: Values = Values(), buildNumber: Values = Values()) {
                self.version = version
                self.buildNumber = buildNumber
            }
        }
        
        public struct Platforms: Hashable, Codable {
            public var macOS: Traits
            public var iOS: Traits
            public var tvOS: Traits
            public var watchOS: Traits
            
            public init(macOS: Traits = Traits(), iOS: Traits = Traits(), tvOS: Traits = Traits(), watchOS: Traits = Traits()) {
                self.macOS = macOS
                self.iOS = iOS
                self.tvOS = tvOS
                self.watchOS = watchOS
            }
        }
        
        public var xcode: Traits = Traits()
        public var platforms: Platforms = Platforms()
        
        public init(xcode: Traits = Traits(), platforms: Platforms = Platforms()) {
            self.xcode = xcode
            self.platforms = platforms
        }
    }
}
