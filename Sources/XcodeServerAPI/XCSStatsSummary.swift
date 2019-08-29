import Foundation

public struct XCSStatsSummary: Codable {
    public var sum: Double
    public var count: Int
    public var min: Double
    public var max: Double
    public var avg: Double
    public var stdDev: Double
    public var sumsqr: Double?
}
