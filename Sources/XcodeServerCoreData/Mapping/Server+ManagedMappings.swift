import XcodeServer
import Foundation
#if canImport(CoreData)

public extension XcodeServer.Server {
    /// Map `XcodeServerCoreData.Server` to `XcodeServe.Server`.
    ///
    /// - parameter server: The managed entity to transform.
    /// - parameter depth: The limit to traversing down the hierarchy.
    init(_ server: XcodeServerCoreData.Server, depth: Int = 0) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Server [\(server.fqdn)] to XcodeServer.Server")
        self.init(id: server.fqdn)
        modified = server.lastUpdate ?? Date()
        version = Version(server)
        
        guard depth > 0 else {
            return
        }
        
        if let bots = server.bots {
            self.bots = Set(bots.map { XcodeServer.Bot($0, depth: depth - 1) })
        }
    }
}

public extension XcodeServer.Server.Version {
    init(_ server: XcodeServerCoreData.Server) {
        InternalLog.coreData.debug("Mapping XcodeServerCoreData.Server [\(server.fqdn)] to XcodeServer.Server.Version")
        self.init()
        api = XcodeServer.Server.API(rawValue: Int(server.apiVersion)) ?? .v19
        app = XcodeServer.Server.App(rawValue: server.xcodeServer ?? "") ?? .v2_0
        macOSVersion = server.os ?? ""
        xcodeAppVersion = server.xcode ?? ""
        serverAppVersion = server.server ?? ""
    }
}

#endif
