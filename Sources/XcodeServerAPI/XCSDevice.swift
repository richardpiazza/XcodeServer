import Foundation

public struct XCSDevice: Codable {
    
    enum CodingKeys: String, CodingKey {
        case activeProxiedDevice
        case architecture
        case deviceType
        case docType = "doc_type"
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
        
        
        case ID
        case revision
        case tinyID
    }
    
    public var activeProxiedDevice: XCSProxiedDeviceDocument?
    public var architecture: String = ""
    public var deviceType: String = ""
    public var docType: String = "device"
    public var identifier: String = UUID().uuidString
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
    
    @available(*, deprecated)
    public var ID: String?
    
    @available(*, deprecated)
    public var revision: String?
    
    @available(*, deprecated)
    public var tinyID: String?
}

public extension XCSDevice {
    @available(*, deprecated, renamed: "isConnected")
    var connected: Bool? {
        return isConnected
    }
    
    @available(*, deprecated, renamed: "isEnabledForDevelopment")
    var enabledForDevelopment: Bool? {
        return isEnabledForDevelopment
    }
    
    @available(*, deprecated, renamed: "isRetina")
    var retina: Bool? {
        return isRetina
    }
    
    @available(*, deprecated, renamed: "isSimulator")
    var simulator: Bool? {
        return isSimulator
    }
    
    @available(*, deprecated, renamed: "isSupported")
    var supported: Bool? {
        return isSupported
    }
    
    @available(*, deprecated, renamed: "isTrusted")
    var trusted: Bool? {
        return isTrusted
    }
}
