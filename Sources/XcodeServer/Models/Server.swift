import Foundation

/// A single 'Xcode Server'.
///
/// The root of the object graph, uniquely identified by its FQDN
/// (Fully Qualified Domain Name) or IP Address.
public struct Server: Hashable, Identifiable {
    
    /// The **FQDN/IP** that is unique to this instance.
    public var id: String
    /// Timestamp indicating the last point in time this instance was updated.
    public var modified: Date = Date()
    public var version: Version = Version()
    public var bots: Set<Bot> = []
    
    public init(id: Server.ID = "", modified: Date = Date(), version: Server.Version = Version(), bots: Set<Bot> = []) {
        self.id = id
        self.modified = modified
        self.version = version
        self.bots = bots
    }
}

public extension Server {
    /// The root API URL for this `Server`.
    ///
    /// Apple by default requires the HTTPS scheme and port 20343.
    var url: URL? {
        return URL(string: "https://\(id):20343/api")
    }
}
