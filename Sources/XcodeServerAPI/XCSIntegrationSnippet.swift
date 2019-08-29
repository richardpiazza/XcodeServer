import Foundation

public struct XCSIntegrationSnippet: Codable {
    
    enum CodingKeys: String, CodingKey {
        case integrationID
        case endedTime
        case successStreak = "success_streak"
    }
    
    public var integrationID: String
    public var endedTime: Date
    public var successStreak: Int?
}
