import Foundation

public struct XCSDevice: Codable {
    
    enum CodingKeys: String, CodingKey {
        case osVersion
        case connected
        case simulator
        case modelCode
        case deviceType
        case modelName
        case revision
        case modelUTI
        case name
        case trusted
        case docType = "doc_type"
        case supported
        case identifier
        case enabledForDevelopment
        case platformIdentifier
        case ID
        case architecture
        case retina
        case isServer
        case tinyID
        case activeProxiedDevice
    }
    
    public var osVersion: String?
    public var connected: Bool?
    public var simulator: Bool?
    public var modelCode: String?
    public var deviceType: String?
    public var modelName: String?
    public var revision: String?
    public var modelUTI: String?
    public var name: String?
    public var trusted: Bool?
    public var docType: String = "device"
    public var supported: Bool?
    public var identifier: String?
    public var enabledForDevelopment: Bool?
    public var platformIdentifier: String?
    public var ID: String?
    public var architecture: String?
    public var retina: Bool?
    public var isServer: Bool?
    public var tinyID: String?
    public var activeProxiedDevice: XCSProxiedDeviceDocument?
}
