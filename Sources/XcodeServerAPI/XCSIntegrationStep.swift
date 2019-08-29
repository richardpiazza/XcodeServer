import Foundation

/// Current step an integration is running.
public enum XCSIntegrationStep: String, Codable {
    case pending
    case preparing
    case checkout
    case triggers
    case building
    case processing
    case uploading
    case completed
    case testing
}
