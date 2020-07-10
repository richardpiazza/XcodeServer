import XcodeServerCommon

/// Versioning information for the Xcode Server and associated components.
public struct XCSVersion: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case docType = "doc_type"
        case macOSVersion = "os"
        case serverAppVersion = "server"
        case tinyID
        case xcodeAppVersion = "xcode"
        case xcodeServerVersion = "xcodeServer"
    }
    
    // MARK: - Document
    /// Document ID
    public var _id: String = ""
    /// Document Revision
    public var _rev: String = ""
    /// Document Type
    public var docType: String = "version"
    @available(*, deprecated, message: "tinyID is not useful for most contexts.")
    public var tinyID: String = ""
    
    // MARK: - Properties
    
    /// **Xcode Server** versioning information
    ///
    /// For example: _2.0_
    public var xcodeServerVersion: String?
    /// **macOS** versioning information
    ///
    /// For example: _10.12 (16A201w)_
    public var macOSVersion: String?
    /// **Xcode.app** versioning information used for builds.
    ///
    /// For example: _8.0 (8S128d)_
    public var xcodeAppVersion: String?
    /// **Server.app** versioning information
    ///
    /// For example: _5.1.50 (16S1083q)_
    public var serverAppVersion: String?
    
    public init() {
    }
}

// MARK: - Identifiable
extension XCSVersion: Identifiable {
    public var id: String {
        get { _id }
        set { _id = newValue }
    }
}

// MARK: - Equatable
extension XCSVersion: Equatable {
}

// MARK: - Hashable
extension XCSVersion: Hashable {
}

// MARK: -
public extension XCSVersion {
    var version: XcodeServerVersion {
        return XcodeServerVersion(rawValue: xcodeServerVersion ?? "") ?? .v2_0
    }
}

// MARK: - Deprecations
public extension XCSVersion {
    @available(*, deprecated, renamed: "macOSVersion")
    var os: String? {
        get { macOSVersion }
        set { macOSVersion = newValue }
    }
    
    @available(*, deprecated, renamed: "xcodeAppVersion")
    var xcode: String? {
        get { xcodeAppVersion }
        set { xcodeAppVersion = newValue }
    }
    
    @available(*, deprecated, renamed: "serverAppVersion")
    var server: String? {
        get { serverAppVersion }
        set { serverAppVersion = newValue }
    }
    
    @available(*, deprecated, renamed: "xcodeServerVersion")
    var xcodeServer: String? {
        get { xcodeServerVersion }
        set { xcodeServerVersion = newValue }
    }
}
