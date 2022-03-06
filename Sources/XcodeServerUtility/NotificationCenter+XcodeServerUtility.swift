import XcodeServer
import Foundation

public extension NotificationCenter {
    /// Convenience method for posting a `.serversDidChange` notification.
    func postServersDidChange() {
        AsyncManager.logger.info("Posting: ServersDidChange")
        post(name: .serversDidChange, object: nil)
    }
    
    /// Convenience for posting a `.serverDidChange` notification.
    ///
    /// - parameter id: Entity ID that will be provided in the _userInfo_ dictionary under the key **Server.ID**.
    func postServerDidChange(_ id: Server.ID) {
        AsyncManager.logger.info("Posting: ServerDidChange [\(id)]")
        post(name: .serverDidChange, object: nil, userInfo: ["Server.ID": id])
    }
    
    /// Convenience for posting a `.botDidChange` notification.
    ///
    /// - parameter id: Entity ID that will be provided in the _userInfo_ dictionary under the key **Bot.ID**.
    func postBotDidChange(_ id: Bot.ID) {
        AsyncManager.logger.info("Posting: BotDidChange [\(id)]")
        post(name: .botDidChange, object: nil, userInfo: ["Bot.ID": id])
    }
    
    /// Convenience for posting a `.integrationDidChange` notification.
    ///
    /// - parameter id: Entity ID that will be provided in the _userInfo_ dictionary under the key **Integration.ID**.
    func postIntegrationDidChange(_ id: Integration.ID) {
        AsyncManager.logger.info("Posting: IntegrationDidChange [\(id)]")
        post(name: .integrationDidChange, object: nil, userInfo: ["Integration.ID": id])
    }
}

public extension Notification.Name {
    /// Notification posted when the composition of persisted `Server`s changed - either through adding or removing.
    static let serversDidChange: Self = Notification.Name("XcodeServer.Utility.ServersDidChange")
    /// Notification posted when a `Server`s versioning information or `Bot` composition is modified.
    static let serverDidChange: Self = Notification.Name("XcodeServer.Utility.ServerDidChange")
    /// Notification posted when a `Bot`s statistics or `Integration` composition is modified.
    static let botDidChange: Self = Notification.Name("XcodeServer.Utility.BotDidChange")
    /// Notification posted when a `Integration`s `Issue` or `Commit` composition is modified.
    static let integrationDidChange: Self = Notification.Name("XcodeServer.Utility.IntegrationDidChange")
}
