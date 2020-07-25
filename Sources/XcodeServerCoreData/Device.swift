import Foundation
#if canImport(CoreData)
import CoreData

@objc(Device)
public class Device: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.isConnected = false
        self.isEnabledForDevelopment = false
        self.isRetina = false
        self.isServer = false
        self.isSimulator = false
        self.isSupported = false
        self.isTrusted = false
        self.isWireless = false
    }
}

// MARK: - CoreData Properties
public extension Device {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: entityName)
    }
    
    @NSManaged var architecture: String?
    @NSManaged var deviceType: String?
    @NSManaged var identifier: String
    @NSManaged var isConnected: Bool
    @NSManaged var isEnabledForDevelopment: Bool
    @NSManaged var isRetina: Bool
    @NSManaged var isServer: Bool
    @NSManaged var isSimulator: Bool
    @NSManaged var isSupported: Bool
    @NSManaged var isTrusted: Bool
    @NSManaged var isWireless: Bool
    @NSManaged var modelCode: String?
    @NSManaged var modelName: String?
    @NSManaged var modelUTI: String?
    @NSManaged var name: String?
    @NSManaged var osVersion: String?
    @NSManaged var platformIdentifier: String?
    
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

#endif
