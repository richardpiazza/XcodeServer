import Foundation

public struct XCSCommitContributor: Codable {
    
    enum CodingKeys: String, CodingKey {
        case emails = "XCSContributorEmails"
        case name = "XCSContributorName"
        case displayName = "XCSContributorDisplayName"
    }
    
    public var emails: [String]?
    public var name: String?
    public var displayName: String?
}
