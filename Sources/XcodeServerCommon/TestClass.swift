import Foundation

public struct TestClass: Codable {
    public var name: String = ""
    public var methods: [TestMethod] = []
    public var aggregateResults: [TestDeviceIdentifier: Double]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TestKey.self)
        try container.allKeys.forEach({ (key) in
            switch key.stringValue {
            case TestKey.aggregateDeviceStatus.stringValue:
                aggregateResults = try container.decodeIfPresent([TestDeviceIdentifier: Double].self, forKey: key)
            default:
                var method = try container.decodeIfPresent(TestMethod.self, forKey: key)
                method?.name = key.stringValue
                if let testMethod = method {
                    methods.append(testMethod)
                }
            }
        })
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TestKey.self)
        try methods.forEach({
            guard let key = TestKey(stringValue: $0.name) else {
                return
            }
            
            try container.encode($0, forKey: key)
        })
        try container.encodeIfPresent(aggregateResults, forKey: TestKey.aggregateDeviceStatus)
    }
}

public extension TestClass {
    var hasFailures: Bool {
        guard let aggregateResults = self.aggregateResults else {
            return methods.contains(where: { $0.hasFailures })
        }
        
        return aggregateResults.contains(where: { $0.value != 1.0 })
    }
}
