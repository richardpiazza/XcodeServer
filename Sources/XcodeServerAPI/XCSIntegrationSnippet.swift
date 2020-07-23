import Foundation

/// Limited identifier information about a specific integration.
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

// MARK: - Identifiable
extension XCSIntegrationSnippet: Identifiable {
    public var id: String {
        get { integrationID }
        set { integrationID = newValue }
    }
}

// MARK: - Equatable
extension XCSIntegrationSnippet: Equatable {
}

// MARK: - Hashable
extension XCSIntegrationSnippet: Hashable {
}
