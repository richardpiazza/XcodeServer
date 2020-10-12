import XcodeServer
#if canImport(CoreData)

public extension XcodeServer.Device {
    init(_ device: XcodeServerCoreData.Device) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Device [\(device.identifier)] to XcodeServer.Device")
        self.init(id: device.identifier)
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

public extension XcodeServer.Device.Platform {
    init(_ platform: Platform) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Platform [\(platform.identifier)] to XcodeServer.Device.Platform")
        self.init(id: platform.identifier)
        buildNumber = platform.buildNumber ?? ""
        displayName = platform.displayName ?? ""
        platformIdentifier = platform.platformIdentifier ?? ""
        simulatorIdentifier = platform.simulatorIdentifier ?? ""
        version = platform.version ?? ""
    }
}

public extension XcodeServer.Device.Filter {
    init(_ filter: Filter) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Filter to XcodeServer.Device.Filter")
        self.init()
        if let platform = filter.platform {
            self.platform = XcodeServer.Device.Platform(platform)
        }
        type = Int(filter.filterTypeRawValue)
        architecture = Int(filter.architectureTypeRawValue)
    }
}

public extension XcodeServer.Device.Specification {
    init(_ specification: DeviceSpecification) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.DeviceSpecification to XcodeServer.Device.Specification")
        self.init()
        if let filters = specification.filters {
            self.filters = filters.map { XcodeServer.Device.Filter($0) }
        }
        if let identifiers = specification.devices {
            devices = Set(identifiers.map { XcodeServer.Device($0) })
        }
    }
}

public extension XcodeServer.Device.ProxiedDevice {
    init(_ device: XcodeServerCoreData.Device) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Device [\(device.identifier)] to XcodeServer.Device.ProxiedDevice")
        self.init(id: device.identifier)
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
