public extension Tests {
    ///
    struct Hierarchy: Hashable, Codable {
        public var suites: [Tests.Suite] = []
        
        public init() {
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Tests.CodingKeys.self)
            try container.allKeys.forEach({ (key) in
                var suite = try container.decodeIfPresent(Tests.Suite.self, forKey: key)
                suite?.name = key.stringValue
                if let testSuite = suite {
                    suites.append(testSuite)
                }
            })
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Tests.CodingKeys.self)
            try suites.forEach({
                guard let key = Tests.CodingKeys(stringValue: $0.name) else {
                    return
                }
                
                try container.encode($0, forKey: key)
            })
        }
    }
}

public extension Tests.Hierarchy {
    var hasFailures: Bool {
        return suites.contains(where: { $0.hasFailures })
    }
}
