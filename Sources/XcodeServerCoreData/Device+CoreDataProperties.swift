import Foundation
import CoreData

public extension Device {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }
    
    @NSManaged var architecture: String?
    @NSManaged var connected: NSNumber?
    @NSManaged var deviceID: String?
    @NSManaged var deviceType: String?
    @NSManaged var enabledForDevelopment: NSNumber?
    @NSManaged var identifier: String?
    @NSManaged var isServer: NSNumber?
    @NSManaged var modelCode: String?
    @NSManaged var modelName: String?
    @NSManaged var modelUTI: String?
    @NSManaged var name: String?
    @NSManaged var osVersion: String?
    @NSManaged var platformIdentifier: String?
    @NSManaged var retina: NSNumber?
    @NSManaged var simulator: NSNumber?
    @NSManaged var supported: NSNumber?
    @NSManaged var trusted: NSNumber?
    @NSManaged var revision: String?
    @NSManaged var activeProxiedDevice: Device?
    @NSManaged var deviceSpecifications: Set<DeviceSpecification>?
    @NSManaged var integrations: Set<Integration>?
    @NSManaged var inverseActiveProxiedDevice: Device?
    
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
