import Foundation
import XcodeServerCommon

public struct XCSIntegration: Codable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case number
        case currentStep
        case result
        case queuedDate
        case successStreak = "success_streak"
        case shouldClean
        case assets
        case buildServiceFingerprint
        case tags
        case startedTime
        case buildResultSummary
        case endedTime
        case duration
        case ccPercentage
        case ccPercentageDelta
        case perfMetricNames
        case perfMetricKeyPaths
        case bot
        case revisionBlueprint
        case testedDevices
        case testHierarchy
        case controlledChanges
    }
    
    public let docType: String = "integration"
    
    public var assets: XCSAssets?
    public var bot: XCSBot?
    public var buildResultSummary: XCSBuildResultSummary?
    public var buildServiceFingerprint: String?
    public var ccPercentage: Int?
    public var ccPercentageDelta: Int?
    public var controlledChanges: XCSControlledChanges?
    public var currentStep: IntegrationStep
    public var duration: Double?
    public var endedTime: Date?
    public var identifier: String = ""
    public var number: Int32
    public var perfMetricKeyPaths: [String]?
    public var perfMetricNames: [String]?
    public var queuedDate: Date?
    public var result: IntegrationResult
    public var revisionBlueprint: XCSRepositoryBlueprint?
    public var shouldClean: Bool?
    public var startedTime: Date?
    public var successStreak: Int32?
    public var tags: [String]?
    public var testedDevices: [XCSDevice]?
    public var testHierarchy: TestHierarchy?
}
