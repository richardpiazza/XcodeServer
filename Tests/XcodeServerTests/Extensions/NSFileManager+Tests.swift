import Foundation
@testable import XcodeServerCoreData

extension FileManager {
    /// Replaces the default SQLite Core Data store with test bundle resources for testing.
    func overwriteDefaultStore(withResource resource: String) throws {
        guard let bundleDb = Bundle.module.url(forResource: resource, withExtension: .sqlite) else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        guard let bundleShm = Bundle.module.url(forResource: resource, withExtension: .sqlite_shm) else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        guard let bundleWal = Bundle.module.url(forResource: resource, withExtension: .sqlite_wal) else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        try purgeDefaultStore()
        try copyItem(at: bundleDb, to: .storeURL)
        try copyItem(at: bundleShm, to: .shmURL)
        try copyItem(at: bundleWal, to: .walURL)
    }
}