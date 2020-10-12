import XcodeServer
import Foundation
#if canImport(CoreData)

public extension XcodeServer.Server {
    init(_ server: XcodeServerCoreData.Server) {
        InternalLog.debug("Mapping XcodeServerCoreData.Server [\(server.fqdn)] to XcodeServer.Server")
        self.init(id: server.fqdn)
        modified = server.lastUpdate ?? Date()
        version = Version(server)
        if let bots = server.bots {
            self.bots = Set(bots.map { XcodeServer.Bot($0) })
        }
    }
}

public extension XcodeServer.Server.Version {
    init(_ server: XcodeServerCoreData.Server) {
        InternalLog.debug("Mapping XcodeServerCoreData.Server [\(server.fqdn)] to XcodeServer.Server.Version")
        self.init()
        api = XcodeServer.Server.API(rawValue: Int(server.apiVersion)) ?? .v19
        app = XcodeServer.Server.App(rawValue: server.xcodeServer ?? "") ?? .v2_0
        macOSVersion = server.os ?? ""
        xcodeAppVersion = server.xcode ?? ""
        serverAppVersion = server.server ?? ""
    }
}

#endif
