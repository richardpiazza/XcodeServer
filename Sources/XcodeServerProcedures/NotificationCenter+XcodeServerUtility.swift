import XcodeServer
import Foundation

public extension NotificationCenter {
    /// Convenience method for posting a `.serversDidChange` notification.
    func postServersDidChange() {
        InternalLog.operations.debug("Posting: ServersDidChange")
        post(name: .serversDidChange, object: nil)
    }
    
    /// Convenience for posting a `.serverDidChange` notification.
    ///
    /// - parameter id: Entity ID that will be provided in the _userInfo_ dictionary under the key **Server.ID**.
    func postServerDidChange(_ id: Server.ID) {
        InternalLog.operations.debug("Posting: ServerDidChange [\(id)]")
        post(name: .serverDidChange, object: nil, userInfo: ["Server.ID": id])
    }
    
    /// Convenience for posting a `.botDidChange` notification.
    ///
    /// - parameter id: Entity ID that will be provided in the _userInfo_ dictionary under the key **Bot.ID**.
    func postBotDidChange(_ id: Bot.ID) {
        InternalLog.operations.debug("Posting: BotDidChange [\(id)]")
        post(name: .botDidChange, object: nil, userInfo: ["Bot.ID": id])
    }
    
    /// Convenience for posting a `.integrationDidChange` notification.
    ///
    /// - parameter id: Entity ID that will be provided in the _userInfo_ dictionary under the key **Integration.ID**.
    func postIntegrationDidChange(_ id: Integration.ID) {
        InternalLog.operations.debug("Posting: IntegrationDidChange [\(id)]")
        post(name: .integrationDidChange, object: nil, userInfo: ["Integration.ID": id])
    }
}

public extension Notification.Name {
    /// Notification posted when the composition of persisted `Server`s changed - either through adding or removing.
    static let serversDidChange: Self = Notification.Name("com.github.richardpiazza.XcodeServer.ServersDidChange")
    /// Notification posted when a `Server`s versioning information or `Bot` composition is modified.
    static let serverDidChange: Self = Notification.Name("com.github.richardpiazza.XcodeServer.ServerDidChange")
    /// Notification posted when a `Bot`s statistics or `Integration` composition is modified.
    static let botDidChange: Self = Notification.Name("com.github.richardpiazza.XcodeServer.BotDidChange")
    /// Notification posted when a `Integration`s `Issue` or `Commit` composition is modified.
    static let integrationDidChange: Self = Notification.Name("com.github.richardpiazza.XcodeServer.IntegrationDidChange")
}
