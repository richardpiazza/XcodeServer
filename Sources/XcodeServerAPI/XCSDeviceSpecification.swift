/// Details the selected devices for a specific bot to use.
public struct XCSDeviceSpecification: Codable {
    ///
    public var filters: [XCSFilter]?
    ///
    public var deviceIdentifiers: [String]?
}

// MARK: - Equatable
extension XCSDeviceSpecification: Equatable {
}

// MARK: - Hashable
extension XCSDeviceSpecification: Hashable {
}
