import Foundation

internal struct TestKey: CodingKey {
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
    
    internal static let aggregateDeviceStatus = TestKey(stringValue: "_xcsAggrDeviceStatus")!
}
