import Foundation
#if canImport(CoreData)
import CoreData

@objc(Device)
public class Device: NSManagedObject {
    
    @NSManaged public var architecture: String?
    @NSManaged public var deviceType: String?
    @NSManaged public var identifier: String
    @NSManaged public var isConnected: Bool
    @NSManaged public var isEnabledForDevelopment: Bool
    @NSManaged public var isRetina: Bool
    @NSManaged public var isServer: Bool
    @NSManaged public var isSimulator: Bool
    @NSManaged public var isSupported: Bool
    @NSManaged public var isTrusted: Bool
    @NSManaged public var isWireless: Bool
    @NSManaged public var modelCode: String?
    @NSManaged public var modelName: String?
    @NSManaged public var modelUTI: String?
    @NSManaged public var name: String?
    @NSManaged public var osVersion: String?
    @NSManaged public var platformIdentifier: String?
    @NSManaged public var activeProxiedDevice: Device?
    @NSManaged public var deviceSpecifications: Set<DeviceSpecification>?
    @NSManaged public var integrations: Set<Integration>?
    @NSManaged public var inverseActiveProxiedDevice: Device?
    
    @objc(addDeviceSpecificationsObject:)
    @NSManaged public func addToDeviceSpecifications(_ value: DeviceSpecification)
    
    @objc(removeDeviceSpecificationsObject:)
    @NSManaged public func removeFromDeviceSpecifications(_ value: DeviceSpecification)
    
    @objc(addDeviceSpecifications:)
    @NSManaged public func addToDeviceSpecifications(_ values: Set<DeviceSpecification>)
    
    @objc(removeDeviceSpecifications:)
    @NSManaged public func removeFromDeviceSpecifications(_ values: Set<DeviceSpecification>)
    
    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: Integration)
    
    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: Integration)
    
    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: Set<Integration>)
    
    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: Set<Integration>)
    
}

#endif
