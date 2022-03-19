///
public struct Device: Hashable, Identifiable, Codable {
    public var id: String
    public var name: String
    public var deviceType: String
    public var modelName: String
    public var modelCode: String
    public var modelUTI: String
    public var osVersion: String
    public var platformIdentifier: String
    public var architecture: String
    public var isConnected: Bool
    public var isSimulator: Bool
    public var isRetina: Bool
    public var isServer: Bool
    public var isTrusted: Bool
    public var isSupported: Bool
    public var isEnabledForDevelopment: Bool
    public var proxiedDevice: ProxiedDevice?
    
    public init(
        id: Device.ID = "",
        name: String = "",
        deviceType: String = "",
        modelName: String = "",
        modelCode: String = "",
        modelUTI: String = "",
        osVersion: String = "",
        platformIdentifier: String = "",
        architecture: String = "",
        isConnected: Bool = false,
        isSimulator: Bool = false,
        isRetina: Bool = false,
        isServer: Bool = false,
        isTrusted: Bool = false,
        isSupported: Bool = false,
        isEnabledForDevelopment: Bool = false,
        proxiedDevice: Device.ProxiedDevice? = nil
    ) {
        self.id = id
        self.name = name
        self.deviceType = deviceType
        self.modelName = modelName
        self.modelCode = modelCode
        self.modelUTI = modelUTI
        self.osVersion = osVersion
        self.platformIdentifier = platformIdentifier
        self.architecture = architecture
        self.isConnected = isConnected
        self.isSimulator = isSimulator
        self.isRetina = isRetina
        self.isServer = isServer
        self.isTrusted = isTrusted
        self.isSupported = isSupported
        self.isEnabledForDevelopment = isEnabledForDevelopment
        self.proxiedDevice = proxiedDevice
    }
}
