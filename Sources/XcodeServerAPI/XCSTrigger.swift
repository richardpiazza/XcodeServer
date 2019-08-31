import Foundation
import XcodeServerCommon

public struct XCSTrigger: Codable {
    public var name: String?
    public var type: TriggerType?
    public var phase: TriggerPhase?
    public var scriptBody: String?
    public var emailConfiguration: XCSEmailConfiguration?
    public var conditions: XCSConditions?
}
