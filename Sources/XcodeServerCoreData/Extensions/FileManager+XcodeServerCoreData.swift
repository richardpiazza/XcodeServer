import XcodeServer
import Foundation

public extension FileManager {
    /// The default `NSPersistentContainer` store url.
    var storeURL: URL {
        let name = "XcodeServer.sqlite"
        return xcodeServerDirectory.appendingPathComponent(name)
    }
}
