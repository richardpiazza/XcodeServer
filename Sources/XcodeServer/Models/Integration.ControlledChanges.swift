public extension Integration {
    
    struct ControlledChanges: Hashable, Codable {
        
        public struct Values: Hashable, Codable {
            public var before: String = ""
            public var after: String = ""
            
            public init() {
            }
        }
        
        public struct Traits: Hashable, Codable {
            public var version: Values = Values()
            public var buildNumber: Values = Values()
            
            public init() {
            }
        }
        
        public struct Platforms: Hashable, Codable {
            public var macOS: Traits = Traits()
            public var iOS: Traits = Traits()
            public var tvOS: Traits = Traits()
            public var watchOS: Traits = Traits()
            
            public init() {
            }
        }
        
        public var xcode: Traits = Traits()
        public var platforms: Platforms = Platforms()
        
        public init() {
        }
    }
}
