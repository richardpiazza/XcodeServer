import Foundation

internal extension String {
    static let containerName: String = "XcodeServer"
    static let configurationName: String = "XcodeServer"
    /// Extension for Core Data SQLite _database_ file
    static let sqlite: String = "sqlite"
    /// Extension for Core Data SQLite _shared memory_ file
    static let sqlite_shm: String = "sqlite-shm"
    /// Extension for Core Data SQLite _write-ahead-log_ file
    static let sqlite_wal: String = "sqlite-wal"
    static let xcmappingmodel: String = "xcmappingmodel"
    /// Extension for processed/compiled `NSMappingModel`s
    static let cdm: String = "cdm"
    /// Extension for processed/compiled `NSManagedObjectModel`s.
    static let momd: String = "momd"
    /// Suffix appended to Copy resources
    static let precompiled: String = "_precompiled"
}
