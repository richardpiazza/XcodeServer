public struct Device: Hashable, Identifiable {
    
    public var id: String
    public var name: String = ""
    public var deviceType: String = ""
    public var modelName: String = ""
    public var modelCode: String = ""
    public var modelUTI: String = ""
    public var osVersion: String = ""
    public var platformIdentifier: String = ""
    public var architecture: String = ""
    public var isConnected: Bool = false
    public var isSimulator: Bool = false
    public var isRetina: Bool = false
    public var isServer: Bool = false
    public var isTrusted: Bool = false
    public var isSupported: Bool = false
    public var isEnabledForDevelopment: Bool = false
    public var proxiedDevice: ProxiedDevice?
    
    public init(id: Device.ID = "") {
        self.id = id
    }
}

public extension Device {
    @available(*, deprecated, renamed: "id")
    var identifier: String {
        get { id }
        set { id = newValue }
    }
}
