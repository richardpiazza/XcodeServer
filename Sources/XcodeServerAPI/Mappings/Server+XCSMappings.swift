import XcodeServer

public extension Server {
    init(id: Server.ID, version: XCSVersion, api: Int?) {
        self.init(id: id)
        self.version = Version(version, api: api)
    }
}

public extension Server.Version {
    init(_ version: XCSVersion, api: Int?) {
        self.init()
        self.api = Server.API(rawValue: api ?? 0) ?? .v19
        app = Server.App(rawValue: version.xcodeServerVersion ?? "") ?? .v2_0
        macOSVersion = version.macOSVersion ?? ""
        xcodeAppVersion = version.xcodeAppVersion ?? ""
        serverAppVersion = version.serverAppVersion ?? ""
    }
}
