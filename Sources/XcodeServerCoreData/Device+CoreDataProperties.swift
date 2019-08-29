import Foundation
import CoreData

public extension Device {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }
    
    @NSManaged public var architecture: String?
    @NSManaged public var connected: NSNumber?
    @NSManaged public var deviceID: String?
    @NSManaged public var deviceType: String?
    @NSManaged public var enabledForDevelopment: NSNumber?
    @NSManaged public var identifier: String?
    @NSManaged public var isServer: NSNumber?
    @NSManaged public var modelCode: String?
    @NSManaged public var modelName: String?
    @NSManaged public var modelUTI: String?
    @NSManaged public var name: String?
    @NSManaged public var osVersion: String?
    @NSManaged public var platformIdentifier: String?
    @NSManaged public var retina: NSNumber?
    @NSManaged public var simulator: NSNumber?
    @NSManaged public var supported: NSNumber?
    @NSManaged public var trusted: NSNumber?
    @NSManaged public var revision: String?
    @NSManaged public var activeProxiedDevice: Device?
    @NSManaged public var deviceSpecifications: Set<DeviceSpecification>?
    @NSManaged public var integrations: Set<Integration>?
    @NSManaged public var inverseActiveProxiedDevice: Device?
    
}

// MARK: Generated accessors for deviceSpecifications
extension Device {
    
    @objc(addDeviceSpecificationsObject:)
    @NSManaged public func addToDeviceSpecifications(_ value: DeviceSpecification)
    
    @objc(removeDeviceSpecificationsObject:)
    @NSManaged public func removeFromDeviceSpecifications(_ value: DeviceSpecification)
    
    @objc(addDeviceSpecifications:)
    @NSManaged public func addToDeviceSpecifications(_ values: Set<DeviceSpecification>)
    
    @objc(removeDeviceSpecifications:)
    @NSManaged public func removeFromDeviceSpecifications(_ values: Set<DeviceSpecification>)
    
}

// MARK: Generated accessors for integrations
extension Device {
    
    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: Integration)
    
    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: Integration)
    
    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: Set<Integration>)
    
    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: Set<Integration>)
    
}
