import Foundation

/// Limited identifier information about a specific integration.
@available(*, deprecated, message: "Appears to no longer be available. Noted Xcode 12.1")
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
@available(*, deprecated, message: "Appears to no longer be available. Noted Xcode 12.1")
extension XCSIntegrationSnippet: Identifiable {
    public var id: String {
        get { integrationID }
        set { integrationID = newValue }
    }
}

// MARK: - Equatable
@available(*, deprecated, message: "Appears to no longer be available. Noted Xcode 12.1")
extension XCSIntegrationSnippet: Equatable {
}

// MARK: - Hashable
@available(*, deprecated, message: "Appears to no longer be available. Noted Xcode 12.1")
extension XCSIntegrationSnippet: Hashable {
}
