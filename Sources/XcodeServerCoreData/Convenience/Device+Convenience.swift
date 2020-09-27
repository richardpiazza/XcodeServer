import XcodeServer
#if canImport(CoreData)
import CoreData

public extension XcodeServerCoreData.Device {
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
            let new = Device(context: context)
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

/*
 extension XcodeServerCoreData.Device {
     public func update(withDevice device: XCSDevice) {
         self.architecture = device.architecture
         self.deviceType = device.deviceType
         self.isConnected = device.isConnected
         self.isEnabledForDevelopment = device.isEnabledForDevelopment
         self.isRetina = device.isRetina
         self.isServer = device.isServer
         self.isSimulator = device.isSimulator
         self.isSupported = device.isSupported
         self.isTrusted = device.isTrusted
         self.isWireless = device.isWireless ?? false
         self.modelCode = device.modelCode
         self.modelName = device.modelName
         self.modelUTI = device.modelUTI
         self.name = device.name
         self.osVersion = device.osVersion
         self.platformIdentifier = device.platformIdentifier
     }
 }
 */

#endif
