import Foundation
import CoreData

@objc(Device)
public class Device: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
    }
}

// MARK: - CoreData Properties
public extension Device {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: entityName)
    }
    
    @NSManaged var architecture: String?
    @NSManaged var deviceType: String?
    @NSManaged var identifier: String?
    @NSManaged var isConnectedRawValue: NSNumber?
    @NSManaged var isEnabledForDevelopmentRawValue: NSNumber?
    @NSManaged var isRetinaRawValue: NSNumber?
    @NSManaged var isServerRawValue: NSNumber?
    @NSManaged var isSimulatorRawValue: NSNumber?
    @NSManaged var isSupportedRawValue: NSNumber?
    @NSManaged var isTrustedRawValue: NSNumber?
    @NSManaged var isWirelessRawValue: NSNumber?
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

public extension Device {
    var isConnected: Bool {
        get {
            guard let rawValue = isConnectedRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            isConnectedRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isEnabledForDevelopment: Bool {
        get {
            guard let rawValue = isEnabledForDevelopmentRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            isEnabledForDevelopmentRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isRetina: Bool {
        get {
            guard let rawValue = isRetinaRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            isRetinaRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isServer: Bool {
        get {
            guard let rawValue = isServerRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            isServerRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isSimulator: Bool {
        get {
            guard let rawValue = isSimulatorRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            isSimulatorRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isSupported: Bool {
        get {
            guard let rawValue = isSupportedRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            isSupportedRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isTrusted: Bool {
        get {
            guard let rawValue = isTrustedRawValue else {
                return false
            }
            
            return Bool(exactly: rawValue) ?? false
        }
        set {
            isTrustedRawValue = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isWireless: Bool? {
        get {
            guard let rawValue = isWirelessRawValue else {
                return nil
            }
            
            return Bool(exactly: rawValue)
        }
        set {
            if let value = newValue {
                isWirelessRawValue = NSNumber(booleanLiteral: value)
            } else {
                isWirelessRawValue = nil
            }
        }
    }
}
