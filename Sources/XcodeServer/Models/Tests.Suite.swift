public extension Tests {
    ///
    struct Suite: Hashable, Codable {
        public var name: String = ""
        public var classes: [Tests.Class] = []
        public var aggregateResults: [Tests.DeviceIdentifier: Double]?
        
        public init() {
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Tests.CodingKeys.self)
            try container.allKeys.forEach({ (key) in
                switch key.stringValue {
                case Tests.CodingKeys.aggregateDeviceStatus.stringValue:
                    aggregateResults = try container.decodeIfPresent([Tests.DeviceIdentifier: Double].self, forKey: key)
                default:
                    var testClass = try container.decodeIfPresent(Tests.Class.self, forKey: key)
                    testClass?.name = key.stringValue
                    if let testClass = testClass {
                        classes.append(testClass)
                    }
                }
            })
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Tests.CodingKeys.self)
            try classes.forEach({
                guard let key = Tests.CodingKeys(stringValue: $0.name) else {
                    return
                }
                
                try container.encode($0, forKey: key)
            })
            try container.encodeIfPresent(aggregateResults, forKey: Tests.CodingKeys.aggregateDeviceStatus)
        }
    }
}

public extension Tests.Suite {
    var hasFailures: Bool {
        guard let aggregateResults = self.aggregateResults else {
            return classes.contains(where: { $0.hasFailures })
        }
        
        return aggregateResults.contains(where: { $0.value != 1.0 })
    }
}
