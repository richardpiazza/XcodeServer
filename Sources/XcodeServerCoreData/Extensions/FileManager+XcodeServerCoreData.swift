import XcodeServer
import Foundation

public extension FileManager {
    
    internal static let containerName: String = "XcodeServer"
    internal static let configurationName: String = "XcodeServer"
    internal static let sqlite: String = "sqlite"
    
    /// The default `NSPersistentContainer` store url.
    var storeURL: URL {
        return xcodeServerDirectory.appendingPathComponent(Self.configurationName).appendingPathExtension(Self.sqlite)
    }
    
    var temporaryStoreURL: URL {
        let filename = "\(Self.configurationName)_temp"
        return xcodeServerDirectory.appendingPathComponent(filename).appendingPathExtension(Self.sqlite)
    }
}
