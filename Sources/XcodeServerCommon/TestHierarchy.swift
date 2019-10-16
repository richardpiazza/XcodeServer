import Foundation

public struct TestHierarchy: Codable {
    public var suites: [TestSuite] = []
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TestKey.self)
        try container.allKeys.forEach({ (key) in
            var suite = try container.decodeIfPresent(TestSuite.self, forKey: key)
            suite?.name = key.stringValue
            if let testSuite = suite {
                suites.append(testSuite)
            }
        })
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TestKey.self)
        try suites.forEach({
            guard let key = TestKey(stringValue: $0.name) else {
                return
            }
            
            try container.encode($0, forKey: key)
        })
    }
}

public extension TestHierarchy {
    var hasFailures: Bool {
        return suites.contains(where: { $0.hasFailures })
    }
}
