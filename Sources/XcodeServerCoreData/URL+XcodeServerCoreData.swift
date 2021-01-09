import Foundation

public extension URL {
    /// The default `NSPersistentContainer` store url.
    static var storeURL: URL {
        return FileManager.default.xcodeServerDirectory
            .appendingPathComponent(.configurationName)
            .appendingPathExtension(.sqlite)
    }
    
    static var temporaryStoreURL: URL {
        let filename = String.configurationName + "_temp"
        return FileManager.default.xcodeServerDirectory
            .appendingPathComponent(filename)
            .appendingPathExtension(.sqlite)
    }
}

public extension URL {
    /// The default `NSPersistentContainer` store _shared memory_ url.
    static var shmURL: URL {
        return storeURL.deletingPathExtension().appendingPathExtension(.sqlite_shm)
    }
    
    /// The default `NSPersistentContainer` store _write-ahead-log_ url.
    static var walURL: URL {
        return storeURL.deletingPathExtension().appendingPathExtension(.sqlite_wal)
    }
}
