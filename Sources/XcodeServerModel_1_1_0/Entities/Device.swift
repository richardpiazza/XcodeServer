import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Device)
public class Device: NSManagedObject {

}

extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var architecture: String?
    @NSManaged public var deviceType: String?
    @NSManaged public var identifier: String?
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
    @NSManaged public var deviceSpecifications: NSSet?
    @NSManaged public var integrations: NSSet?
    @NSManaged public var inverseActiveProxiedDevice: Device?

}

// MARK: Generated accessors for deviceSpecifications
extension Device {

    @objc(addDeviceSpecificationsObject:)
    @NSManaged public func addToDeviceSpecifications(_ value: DeviceSpecification)

    @objc(removeDeviceSpecificationsObject:)
    @NSManaged public func removeFromDeviceSpecifications(_ value: DeviceSpecification)

    @objc(addDeviceSpecifications:)
    @NSManaged public func addToDeviceSpecifications(_ values: NSSet)

    @objc(removeDeviceSpecifications:)
    @NSManaged public func removeFromDeviceSpecifications(_ values: NSSet)

}

// MARK: Generated accessors for integrations
extension Device {

    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: Integration)

    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: Integration)

    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: NSSet)

    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: NSSet)

}

public extension Device {
    /// Retrieves all `Device` entities from the Core Data `NSManagedObjectContext`
    static func devices(in context: NSManagedObjectContext) -> [Device] {
        let request = NSFetchRequest<Device>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.coreData.error("Failed to fetch all devices", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `Device` entity from the Core Data `NSManagedObjectContext` that matches the specified id.
    static func device(_ id: XcodeServer.Device.ID, in context: NSManagedObjectContext) -> Device? {
        let request = NSFetchRequest<Device>(entityName: entityName)
        request.predicate = NSPredicate(format: "identifier = %@", argumentArray: [id])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.coreData.error("Failed to fetch device '\(id)'", error: error)
        }
        
        return nil
    }
}

public extension Device {
    func update(_ device: XcodeServer.Device, context: NSManagedObjectContext) {
        identifier = device.id
        architecture = device.architecture
        deviceType = device.deviceType
        isConnected = device.isConnected
        isEnabledForDevelopment = device.isEnabledForDevelopment
        isRetina = device.isRetina
        isServer = device.isServer
        isSimulator = device.isSimulator
        isSupported = device.isSupported
        isTrusted = device.isTrusted
        modelCode = device.modelCode
        modelName = device.modelName
        modelUTI = device.modelUTI
        name = device.name
        osVersion = device.osVersion
        platformIdentifier = device.platformIdentifier
        
        switch (activeProxiedDevice, device.proxiedDevice) {
        case (.none, .none):
            break
        case (.some, .none):
            activeProxiedDevice = nil
        case (.some, .some(let proxiedDevice)):
            activeProxiedDevice?.update(proxiedDevice)
        case (.none, .some(let proxiedDevice)):
            let new: Device = context.make()
            new.update(proxiedDevice)
            activeProxiedDevice = new
        }
    }
    
    func update(_ device: XcodeServer.Device.ProxiedDevice) {
        identifier = device.id
        architecture = device.architecture
        deviceType = device.deviceType
        isConnected = device.isConnected
        isEnabledForDevelopment = device.isEnabledForDevelopment
        isRetina = device.isRetina
        isServer = device.isServer
        isSimulator = device.isSimulator
        isSupported = device.isSupported
        isTrusted = device.isTrusted
        modelCode = device.modelCode
        modelName = device.modelName
        modelUTI = device.modelUTI
        name = device.name
        osVersion = device.osVersion
        platformIdentifier = device.platformIdentifier
    }
}

public extension XcodeServer.Device {
    init(_ device: Device) {
        self.init(id: device.identifier ?? "")
        name = device.name ?? ""
        deviceType = device.deviceType ?? ""
        modelName = device.modelName ?? ""
        modelCode = device.modelCode ?? ""
        modelUTI = device.modelUTI ?? ""
        osVersion = device.osVersion ?? ""
        platformIdentifier = device.platformIdentifier ?? ""
        architecture = device.architecture ?? ""
        isConnected = device.isConnected
        isSimulator = device.isSimulator
        isRetina = device.isRetina
        isServer = device.isServer
        isTrusted = device.isTrusted
        isSupported = device.isSupported
        isEnabledForDevelopment = device.isEnabledForDevelopment
        if let proxy = device.activeProxiedDevice {
            proxiedDevice = XcodeServer.Device.ProxiedDevice(proxy)
        }
    }
}

public extension XcodeServer.Device.ProxiedDevice {
    init(_ device: Device) {
        self.init(id: device.identifier ?? "")
        name = device.name ?? ""
        deviceType = device.deviceType ?? ""
        modelName = device.modelName ?? ""
        modelCode = device.modelCode ?? ""
        modelUTI = device.modelUTI ?? ""
        osVersion = device.osVersion ?? ""
        platformIdentifier = device.platformIdentifier ?? ""
        architecture = device.architecture ?? ""
        isConnected = device.isConnected
        isSimulator = device.isSimulator
        isRetina = device.isRetina
        isServer = device.isServer
        isTrusted = device.isTrusted
        isSupported = device.isSupported
        isEnabledForDevelopment = device.isEnabledForDevelopment
    }
}
#endif
