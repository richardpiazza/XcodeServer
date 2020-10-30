/// Versioning information for the Xcode Server and associated components.
public struct XCSVersion: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case docType = "doc_type"
        case macOSVersion = "os"
        case serverAppVersion = "server"
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
