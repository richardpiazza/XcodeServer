import Foundation

/// A simple enumeration with cases supporting either the expected
/// `T` type or an `Error`.
public enum XCServerResult<T> {
    case value(T)
    case error(Swift.Error)
    
    public var value: T? {
        switch self {
        case .value(let result):
            return result
        default:
            return nil
        }
    }
    
    public var error: Swift.Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
