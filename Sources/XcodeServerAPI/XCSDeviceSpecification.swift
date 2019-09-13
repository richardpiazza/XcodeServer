import Foundation

public struct XCSDeviceSpecification: Codable {
    public var filters: [XCSFilter]?
    public var deviceIdentifiers: [String]?
}
