/// XCTest results hierarchy
public struct XCSTests: Codable {
    
    struct TestKey: CodingKey {
        var stringValue: String
        var intValue: Int? {
            return nil
        }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
        
        static let aggregateDeviceStatus = TestKey(stringValue: "_xcsAggrDeviceStatus")!
    }
    
    public var suites: [XCSTestSuite] = []
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TestKey.self)
        try container.allKeys.forEach({ (key) in
            var suite = try container.decodeIfPresent(XCSTestSuite.self, forKey: key)
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

public extension XCSTests {
    typealias DeviceIdentifier = String
}

public extension XCSTests {
    struct XCSTestSuite: Codable {
        public var name: String = ""
        public var classes: [XCSTestClass] = []
        public var aggregateResults: [DeviceIdentifier: Double]?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TestKey.self)
            try container.allKeys.forEach({ (key) in
                switch key.stringValue {
                case TestKey.aggregateDeviceStatus.stringValue:
                    aggregateResults = try container.decodeIfPresent([DeviceIdentifier: Double].self, forKey: key)
                default:
                    var testClass = try container.decodeIfPresent(XCSTestClass.self, forKey: key)
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
}

public extension XCSTests {
    struct XCSTestClass: Codable {
        public var name: String = ""
        public var methods: [XCSTestMethod] = []
        public var aggregateResults: [DeviceIdentifier: Double]?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TestKey.self)
            try container.allKeys.forEach({ (key) in
                switch key.stringValue {
                case TestKey.aggregateDeviceStatus.stringValue:
                    aggregateResults = try container.decodeIfPresent([DeviceIdentifier: Double].self, forKey: key)
                default:
                    var method = try container.decodeIfPresent(XCSTestMethod.self, forKey: key)
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
}

public extension XCSTests {
    struct XCSTestMethod: Codable {
        public var name: String = ""
        public var deviceResults: [DeviceIdentifier: Int] = [:]
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TestKey.self)
            try container.allKeys.forEach { (key) in
                if let value = try container.decodeIfPresent(Int.self, forKey: key) {
                    deviceResults[key.stringValue] = value
                }
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: TestKey.self)
            try deviceResults.forEach({
                if let key = TestKey(stringValue: $0.key) {
                    try container.encode($0.value, forKey: key)
                }
            })
        }
    }
}
