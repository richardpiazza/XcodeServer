/// Descriptive information about an integration environment.
public struct XCSPlatform: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case buildNumber
        case displayName
        case platformIdentifier = "identifier"
        case simulatorIdentifier
        case version
    }
    
    public var _id: String
    public var buildNumber: String?
    public var displayName: String?
    public var platformIdentifier: String?
    public var simulatorIdentifier: String?
    public var version: String?
}

// MARK: - Identifiable
extension XCSPlatform: Identifiable {
    public var id: String {
        get { _id }
        set { _id = newValue }
    }
}

// MARK: - Equatable
extension XCSPlatform: Equatable {
}

// MARK: - Hashable
extension XCSPlatform: Hashable {
}

// MARK: - Deprecations
public extension XCSPlatform {
    @available(*, deprecated, renamed: "id")
    var identifier: String {
        get { _id }
        set { _id = newValue }
    }
}
