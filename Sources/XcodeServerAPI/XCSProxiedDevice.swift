import Foundation

public struct XCSProxiedDeviceDocument: Codable {
    
    enum CodingKeys: String, CodingKey {
        case osVersion
        case connected
        case simulator
        case modelCode
        case deviceType
        case modelName
        case modelUTI
        case name
        case trusted
        case docType = "doc_type"
        case supported
        case identifier
        case enabledForDevelopment
        case platformIdentifier
        case architecture
        case retina
        case isServer
    }
    
    public var osVersion: String?
    public var connected: Bool?
    public var simulator: Bool?
    public var modelCode: String?
    public var deviceType: String?
    public var modelName: String?
    public var modelUTI: String?
    public var name: String?
    public var trusted: Bool?
    public var docType: String = "device"
    public var supported: Bool?
    public var identifier: String?
    public var enabledForDevelopment: Bool?
    public var platformIdentifier: String?
    public var architecture: String?
    public var retina: Bool?
    public var isServer: Bool?
}
