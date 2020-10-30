public struct Tests {
    ///
    public typealias DeviceIdentifier = String
    ///
    public typealias Results = (name: String, result: Result)
    
    struct CodingKeys: CodingKey {
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
        
        internal static let aggregateDeviceStatus = Tests.CodingKeys(stringValue: "_xcsAggrDeviceStatus")!
    }
    
    ///
    public enum Result: Int {
        case passed = 0
        case failed = 1
        case skipped = 2
    }
}
