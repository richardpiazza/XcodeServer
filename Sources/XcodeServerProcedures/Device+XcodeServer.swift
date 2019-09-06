import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Device {
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
