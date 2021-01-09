import Foundation

public extension FileManager {
    /// Removes the default `NSPersistentContainer` store files.
    func purgeDefaultStore() throws {
        let localDb: URL = .storeURL
        if fileExists(atPath: localDb.path) {
            try removeItem(at: localDb)
        }
        
        let localShm: URL = .shmURL
        if fileExists(atPath: localShm.path) {
            try removeItem(at: localShm)
        }
        
        let localWal: URL = .walURL
        if fileExists(atPath: localWal.path) {
            try removeItem(at: localWal)
        }
    }
}
