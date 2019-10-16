import Foundation

public struct TestMethod: Codable {
    public var name: String = ""
    public var deviceResults: [TestDeviceIdentifier: Int] = [:]
    
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

public extension TestMethod {
    var hasFailures: Bool {
        return deviceResults.contains(where: { $0.value == 0 })
    }
}
