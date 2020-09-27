public extension Tests {
    struct Class: Hashable, Codable {
        public var name: String = ""
        public var methods: [Tests.Method] = []
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
                    var method = try container.decodeIfPresent(Tests.Method.self, forKey: key)
                    method?.name = key.stringValue
                    if let testMethod = method {
                        methods.append(testMethod)
                    }
                }
            })
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Tests.CodingKeys.self)
            try methods.forEach({
                guard let key = Tests.CodingKeys(stringValue: $0.name) else {
                    return
                }
                
                try container.encode($0, forKey: key)
            })
            try container.encodeIfPresent(aggregateResults, forKey: Tests.CodingKeys.aggregateDeviceStatus)
        }
    }
}

public extension Tests.Class {
    var hasFailures: Bool {
        guard let aggregateResults = self.aggregateResults else {
            return methods.contains(where: { $0.hasFailures })
        }
        
        return aggregateResults.contains(where: { $0.value != 1.0 })
    }
}

@available(*, deprecated, renamed: "Tests.Class")
public typealias TestClass = Tests.Class
