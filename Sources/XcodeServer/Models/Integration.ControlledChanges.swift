public extension Integration {
    
    struct ControlledChanges: Hashable {
        
        public struct Values: Hashable {
            public var before: String = ""
            public var after: String = ""
            
            public init() {
            }
        }
        
        public struct Traits: Hashable {
            public var version: Values = Values()
            public var buildNumber: Values = Values()
            
            public init() {
            }
        }
        
        public struct Platforms: Hashable {
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
