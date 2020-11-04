import Foundation

/// An API response that contains a result set & count.
public struct XCSResults<T>: Codable where T: Codable {
    public var count: Int = 0
    public var results: [T]
}
