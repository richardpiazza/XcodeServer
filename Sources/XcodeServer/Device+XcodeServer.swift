import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Device {
    public func update(withDevice device: XCSDevice) {
        self.name = device.name
        self.deviceType = device.deviceType
        self.connected = device.connected as NSNumber?
        self.simulator = device.simulator as NSNumber?
        self.osVersion = device.osVersion
        self.supported = device.supported as NSNumber?
        self.enabledForDevelopment = device.enabledForDevelopment as NSNumber?
        self.architecture = device.architecture
        self.isServer = device.isServer as NSNumber?
        self.platformIdentifier = device.platformIdentifier
        self.retina = device.retina as NSNumber?
        self.revision = device.revision
    }
}
