import XcodeServer

public extension Device {
    init(_ device: XCSDevice) {
        self.init(id: device.id)
        name = device.name
        deviceType = device.deviceType
        modelName = device.modelName
        modelCode = device.modelCode
        modelUTI = device.modelUTI
        osVersion = device.osVersion
        platformIdentifier = device.platformIdentifier
        architecture = device.architecture
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

public extension Device.Platform {
    init(_ platform: XCSPlatform) {
        self.init(id: platform.id)
        buildNumber = platform.buildNumber ?? ""
        displayName = platform.displayName ?? ""
        platformIdentifier = platform.platformIdentifier ?? ""
        simulatorIdentifier = platform.simulatorIdentifier ?? ""
        version = platform.version ?? ""
    }
}

public extension Device.Filter {
    init(_ filter: XCSFilter) {
        self.init()
        if let platform = filter.platform {
            self.platform = Device.Platform(platform)
        }
        type = filter.filterType ?? 0
        architecture = filter.architectureType ?? 0
    }
}

public extension Device.Specification {
    init(_ specification: XCSDeviceSpecification) {
        self.init()
        if let filters = specification.filters {
            self.filters = filters.map { Device.Filter($0) }
        }
        if let identifiers = specification.deviceIdentifiers {
            devices = Set(identifiers.map { Device(id: $0) })
        }
    }
}

public extension Device.ProxiedDevice {
    init(_ device: XCSProxiedDevice) {
        self.init(id: device.id)
        name = device.name ?? ""
        deviceType = device.deviceType ?? ""
        modelName = device.modelName ?? ""
        modelCode = device.modelCode ?? ""
        modelUTI = device.modelUTI ?? ""
        osVersion = device.osVersion ?? ""
        platformIdentifier = device.platformIdentifier ?? ""
        architecture = device.architecture ?? ""
        isConnected = device.connected ?? false
        isSimulator = device.simulator ?? false
        isRetina = device.retina ?? false
        isServer = device.isServer ?? false
        isTrusted = device.trusted ?? false
        isSupported = device.supported ?? false
        isEnabledForDevelopment = device.enabledForDevelopment ?? false
    }
}
