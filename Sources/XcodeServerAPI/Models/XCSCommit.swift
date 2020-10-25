import Foundation

/// A reference to the source control commits that contributed to an integration.
public struct XCSCommit: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case docType = "doc_type"
        case integration
        case botID
        case endedTimeDate
        case commits
    }
    
    // MARK: - Document
    
    /// Document ID
    public var _id: String
    /// Document Revision
    public var _rev: String
    /// Document Type
    public var docType: String = "commit"
    
    // MARK: - Properties
    
    ///
    public var botID: String?
    ///
    public var commits: [String : [XCSRepositoryCommit]]?
    ///
    public var endedTimeDate: [Int]?
    ///
    public var integration: String?
}

// MARK: - Identifiable
extension XCSCommit: Identifiable {
    public var id: String {
        get { _id }
        set { _id = newValue }
    }
}

// MARK: - Equatable
extension XCSCommit: Equatable {
}

// MARK: - Hashable
extension XCSCommit: Hashable {
}
