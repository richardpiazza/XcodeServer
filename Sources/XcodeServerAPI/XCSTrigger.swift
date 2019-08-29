import Foundation

public struct XCSTrigger: Codable {
    public var name: String?
    public var type: XCSTriggerType?
    public var phase: XCSTriggerPhase?
    public var scriptBody: String?
    public var emailConfiguration: XCSEmailConfiguration?
    public var conditions: XCSConditions?
}
