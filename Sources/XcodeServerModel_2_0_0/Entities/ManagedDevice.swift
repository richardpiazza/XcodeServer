import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedDevice: NSManagedObject {

}

extension ManagedDevice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedDevice> {
        return NSFetchRequest<ManagedDevice>(entityName: "ManagedDevice")
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
    @NSManaged public var activeProxiedDevice: ManagedDevice?
    @NSManaged public var deviceSpecifications: NSSet?
    @NSManaged public var integrations: NSSet?
    @NSManaged public var inverseActiveProxiedDevice: ManagedDevice?

}

// MARK: Generated accessors for deviceSpecifications
extension ManagedDevice {

    @objc(addDeviceSpecificationsObject:)
    @NSManaged public func addToDeviceSpecifications(_ value: ManagedDeviceSpecification)

    @objc(removeDeviceSpecificationsObject:)
    @NSManaged public func removeFromDeviceSpecifications(_ value: ManagedDeviceSpecification)

    @objc(addDeviceSpecifications:)
    @NSManaged public func addToDeviceSpecifications(_ values: NSSet)

    @objc(removeDeviceSpecifications:)
    @NSManaged public func removeFromDeviceSpecifications(_ values: NSSet)

}

// MARK: Generated accessors for integrations
extension ManagedDevice {

    @objc(addIntegrationsObject:)
    @NSManaged public func addToIntegrations(_ value: ManagedIntegration)

    @objc(removeIntegrationsObject:)
    @NSManaged public func removeFromIntegrations(_ value: ManagedIntegration)

    @objc(addIntegrations:)
    @NSManaged public func addToIntegrations(_ values: NSSet)

    @objc(removeIntegrations:)
    @NSManaged public func removeFromIntegrations(_ values: NSSet)

}

extension ManagedDevice {
    /// Retrieves all `Device` entities from the Core Data `NSManagedObjectContext`
    static func devices(in context: NSManagedObjectContext) -> [ManagedDevice] {
        let request = fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            PersistentContainer.logger.error("Failed to fetch `[ManagedDevice]`.", metadata: [
                "localizedDescription": .string(error.localizedDescription)
            ])
        }
        
        return []
    }
    
    /// Retrieves the first `Device` entity from the Core Data `NSManagedObjectContext` that matches the specified id.
    static func device(_ id: Device.ID, in context: NSManagedObjectContext) -> ManagedDevice? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedDevice.identifier), id)
        do {
            return try context.fetch(request).first
        } catch {
            PersistentContainer.logger.error("Failed to fetch `ManagedDevice`.", metadata: [
                "Device.ID": .string(id),
                "localizedDescription": .string(error.localizedDescription)
            ])
        }
        
        return nil
    }
    
    func update(_ device: Device, context: NSManagedObjectContext) {
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
            let new: ManagedDevice = context.make()
            new.update(proxiedDevice)
            activeProxiedDevice = new
        }
    }
    
    func update(_ device: Device.ProxiedDevice) {
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

extension Device {
    init(_ device: ManagedDevice) {
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
            proxiedDevice = Device.ProxiedDevice(proxy)
        }
    }
}

extension Device.ProxiedDevice {
    init(_ device: ManagedDevice) {
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
