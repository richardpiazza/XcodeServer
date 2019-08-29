import Foundation

public typealias XCSDeviceIdentifier = String
public typealias XCSAggregateResults = [XCSDeviceIdentifier : Double]
public typealias XCSDeviceResults = [XCSDeviceIdentifier : Int]

internal struct XCSTestHierarchyKey: CodingKey {
    internal var stringValue: String
    internal var intValue: Int? {
        return nil
    }
    
    internal init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    internal init?(intValue: Int) {
        return nil
    }
    
    internal static let aggregateDeviceStatusKey = XCSTestHierarchyKey(stringValue: "_xcsAggrDeviceStatus")
}


public struct XCSTestMethod: Codable {
    public var name: String = ""
    public var deviceResults: XCSDeviceResults = XCSDeviceResults()
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: XCSTestHierarchyKey.self)
        for key in container.allKeys {
            let value = try container.decodeIfPresent(Int.self, forKey: key)
            if let v = value {
                deviceResults[key.stringValue] = v
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: XCSTestHierarchyKey.self)
        for key in deviceResults.keys {
            guard let hierarchyKey = XCSTestHierarchyKey(stringValue: key) else {
                continue
            }
            
            try container.encode(deviceResults[key], forKey: hierarchyKey)
        }
    }
    
    public var hasFailures: Bool {
        return self.deviceResults.contains { (key, value) -> Bool in
            return value == 0
        }
    }
}

public struct XCSTestClass: Codable {
    public var name: String = ""
    public var methods: [XCSTestMethod] = [XCSTestMethod]()
    public var aggregateResults: XCSAggregateResults?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: XCSTestHierarchyKey.self)
        for key in container.allKeys {
            if key.stringValue == XCSTestHierarchyKey.aggregateDeviceStatusKey?.stringValue {
                self.aggregateResults = try container.decodeIfPresent(XCSAggregateResults.self, forKey: key)
            } else {
                var method = try container.decodeIfPresent(XCSTestMethod.self, forKey: key)
                method?.name = key.stringValue
                if let m = method {
                    self.methods.append(m)
                }
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: XCSTestHierarchyKey.self)
        for method in methods {
            guard let key = XCSTestHierarchyKey(stringValue: method.name) else {
                continue
            }
            
            try container.encode(method, forKey: key)
        }
        if let aggregateResults = self.aggregateResults, let key = XCSTestHierarchyKey.aggregateDeviceStatusKey {
            try container.encode(aggregateResults, forKey: key)
        }
    }
    
    public var hasFailures: Bool {
        if let aggregateResults = self.aggregateResults {
            return aggregateResults.contains(where: { (key, value) -> Bool in
                return value != 1.0
            })
        }
        
        return self.methods.contains(where: { (method) -> Bool in
            return method.hasFailures
        })
    }
}

public struct XCSTestSuite: Codable {
    public var name: String = ""
    public var classes: [XCSTestClass] = [XCSTestClass]()
    public var aggregateResults: XCSAggregateResults?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: XCSTestHierarchyKey.self)
        for key in container.allKeys {
            if key.stringValue == XCSTestHierarchyKey.aggregateDeviceStatusKey?.stringValue {
                self.aggregateResults = try container.decodeIfPresent(XCSAggregateResults.self, forKey: key)
            } else {
                var `class` = try container.decodeIfPresent(XCSTestClass.self, forKey: key)
                `class`?.name = key.stringValue
                if let c = `class` {
                    self.classes.append(c)
                }
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: XCSTestHierarchyKey.self)
        for `class` in classes {
            guard let key = XCSTestHierarchyKey(stringValue: `class`.name) else {
                continue
            }
            
            try container.encode(`class`, forKey: key)
        }
        if let aggregateResults = self.aggregateResults, let key = XCSTestHierarchyKey.aggregateDeviceStatusKey {
            try container.encode(aggregateResults, forKey: key)
        }
    }
    
    public var hasFailures: Bool {
        if let aggregateResults = self.aggregateResults {
            return aggregateResults.contains(where: { (key, value) -> Bool in
                return value != 1.0
            })
        }
        
        return self.classes.contains(where: { (`class`) -> Bool in
            return `class`.hasFailures
        })
    }
}

public struct XCSTestHierarchy: Codable {
    public var suites: [XCSTestSuite] = [XCSTestSuite]()
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: XCSTestHierarchyKey.self)
        for key in container.allKeys {
            var suite = try container.decodeIfPresent(XCSTestSuite.self, forKey: key)
            suite?.name = key.stringValue
            if let s = suite {
                suites.append(s)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: XCSTestHierarchyKey.self)
        for suite in suites {
            guard let key = XCSTestHierarchyKey(stringValue: suite.name) else {
                continue
            }
            
            try container.encode(suite, forKey: key)
        }
    }
    
    public var hasFailures: Bool {
        return self.suites.contains(where: { (suite) -> Bool in
            return suite.hasFailures
        })
    }
}

