import Foundation

public struct TestSuite: Codable {
    public var name: String = ""
    public var classes: [TestClass] = []
    public var aggregateResults: [TestDeviceIdentifier: Double]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TestKey.self)
        try container.allKeys.forEach({ (key) in
            switch key.stringValue {
            case TestKey.aggregateDeviceStatus.stringValue:
                aggregateResults = try container.decodeIfPresent([TestDeviceIdentifier: Double].self, forKey: key)
            default:
                var testClass = try container.decodeIfPresent(TestClass.self, forKey: key)
                testClass?.name = key.stringValue
                if let testClass = testClass {
                    classes.append(testClass)
                }
            }
        })
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TestKey.self)
        try classes.forEach({
            guard let key = TestKey(stringValue: $0.name) else {
                return
            }
            
            try container.encode($0, forKey: key)
        })
        try container.encodeIfPresent(aggregateResults, forKey: TestKey.aggregateDeviceStatus)
    }
}

public extension TestSuite {
    var hasFailures: Bool {
        guard let aggregateResults = self.aggregateResults else {
            return classes.contains(where: { $0.hasFailures })
        }
        
        return aggregateResults.contains(where: { $0.value != 1.0 })
    }
}
