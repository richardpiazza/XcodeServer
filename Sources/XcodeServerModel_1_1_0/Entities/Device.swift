import XcodeServer
import CoreDataPlus
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Device)
class Device: NSManagedObject {

}

extension Device {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged var architecture: String?
    @NSManaged var deviceType: String?
    @NSManaged var identifier: String?
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
    @NSManaged var deviceSpecifications: NSSet?
    @NSManaged var integrations: NSSet?
    @NSManaged var inverseActiveProxiedDevice: Device?

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

extension Device {
    /// Retrieves all `Device` entities from the Core Data `NSManagedObjectContext`
    static func devices(in context: NSManagedObjectContext) -> [Device] {
        let request = NSFetchRequest<Device>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            PersistentContainer.logger.error("Failed to fetch all devices", metadata: ["localizedDescription": .string(error.localizedDescription)])
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
            PersistentContainer.logger.error("Failed to fetch device '\(id)'", metadata: ["localizedDescription": .string(error.localizedDescription)])
        }
        
        return nil
    }
}

extension Device {
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

extension XcodeServer.Device {
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

extension XcodeServer.Device.ProxiedDevice {
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
