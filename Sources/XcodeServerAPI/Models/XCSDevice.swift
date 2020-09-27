/// Information pertaining to a specific testing device.
public struct XCSDevice: Codable {
    
    enum CodingKeys: String, CodingKey {
        case activeProxiedDevice
        case architecture
        case deviceType
        case identifier
        case isConnected = "connected"
        case isEnabledForDevelopment = "enabledForDevelopment"
        case isRetina = "retina"
        case isServer
        case isSimulator = "simulator"
        case isSupported = "supported"
        case isTrusted = "trusted"
        case isWireless = "wireless"
        case modelCode
        case modelName
        case modelUTI
        case name
        case osVersion
        case platformIdentifier
    }
    
    public let docType: String = "device"
    
    public var activeProxiedDevice: XCSProxiedDevice?
    public var architecture: String = ""
    public var deviceType: String = ""
    public var identifier: String = ""
    public var isConnected: Bool = false
    public var isEnabledForDevelopment: Bool = false
    public var isRetina: Bool = false
    public var isServer: Bool = false
    public var isSimulator: Bool = false
    public var isSupported: Bool = false
    public var isTrusted: Bool = false
    public var isWireless: Bool?
    public var modelCode: String = ""
    public var modelName: String = ""
    public var modelUTI: String = ""
    public var name: String = ""
    public var osVersion: String = ""
    public var platformIdentifier: String = ""
    
    public init() {
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activeProxiedDevice = try container.decodeIfPresent(XCSProxiedDevice.self, forKey: .activeProxiedDevice)
        architecture = try container.decodeIfPresent(String.self, forKey: .architecture) ?? ""
        deviceType = try container.decode(String.self, forKey: .deviceType)
        identifier = try container.decode(String.self, forKey: .identifier)
        isConnected = try container.decode(Bool.self, forKey: .isConnected)
        isEnabledForDevelopment = try container.decode(Bool.self, forKey: .isEnabledForDevelopment)
        isRetina = try container.decode(Bool.self, forKey: .isRetina)
        isServer = try container.decode(Bool.self, forKey: .isServer)
        isSimulator = try container.decode(Bool.self, forKey: .isSimulator)
        isSupported = try container.decode(Bool.self, forKey: .isSupported)
        isTrusted = try container.decode(Bool.self, forKey: .isTrusted)
        isWireless = try container.decodeIfPresent(Bool.self, forKey: .isWireless)
        modelCode = try container.decode(String.self, forKey: .modelCode)
        modelName = try container.decode(String.self, forKey: .modelName)
        modelUTI = try container.decode(String.self, forKey: .modelUTI)
        name = try container.decode(String.self, forKey: .name)
        osVersion = try container.decode(String.self, forKey: .osVersion)
        platformIdentifier = try container.decode(String.self, forKey: .platformIdentifier)
    }
}

// MARK: - Identifiable
extension XCSDevice: Identifiable {
    public var id: String {
        get { identifier}
        set { identifier = newValue }
    }
}

// MARK: - Equatable
extension XCSDevice: Equatable {
}

// MARK: - Hashable
extension XCSDevice: Hashable {
}
