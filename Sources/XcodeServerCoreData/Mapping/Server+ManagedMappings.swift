import XcodeServer
import Foundation
#if canImport(CoreData)

public extension XcodeServer.Server {
    /// Map `XcodeServerCoreData.Server` to `XcodeServe.Server`.
    ///
    /// - parameter server: The managed entity to transform.
    init(_ server: XcodeServerCoreData.Server) {
        self.init(id: server.fqdn ?? "")
        modified = server.lastUpdate ?? Date()
        version = Version(server)
        if let bots = server.bots as? Set<Bot> {
            self.bots = Set(bots.map { XcodeServer.Bot($0) })
        }
    }
}

public extension XcodeServer.Server.Version {
    init(_ server: XcodeServerCoreData.Server) {
        self.init()
        api = XcodeServer.Server.API(rawValue: Int(server.apiVersion)) ?? .v19
        app = XcodeServer.Server.App(rawValue: server.xcodeServer ?? "") ?? .v2_0
        macOSVersion = server.os ?? ""
        xcodeAppVersion = server.xcode ?? ""
        serverAppVersion = server.server ?? ""
    }
}

#endif
