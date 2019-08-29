import Foundation

public struct XCSIntegration: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case number
        case currentStep
        case result
        case queuedDate
        case successStreak = "success_streak"
        case shouldClean
        case assets
        case docType = "doc_type"
        case tinyID
        case buildServiceFingerprint
        case tags
        case startedTime
        case buildResultSummary
        case endedTime
        case endedTimeDate
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
    
    public var _id: String
    public var _rev: String
    public var number: Int
    public var currentStep: XCSIntegrationStep
    public var result: XCSIntegrationResult
    public var queuedDate: Date?
    public var successStreak: Int?
    public var shouldClean: Bool?
    public var assets: XCSAssets?
    public var docType: String = "integration"
    public var tinyID: String?
    public var buildServiceFingerprint: String?
    public var tags: [String]?
    public var startedTime: Date?
    public var buildResultSummary: XCSBuildResultSummary?
    public var endedTime: Date?
    public var endedTimeDate: [Int]?
    public var duration: Double?
    public var ccPercentage: Int?
    public var ccPercentageDelta: Int?
    public var perfMetricNames: [String]?
    public var perfMetricKeyPaths: [String]?
    public var bot: XCSBot?
    public var revisionBlueprint: XCSRepositoryBlueprint?
    public var testedDevices: [XCSDevice]?
    public var testHierarchy: XCSTestHierarchy?
    public var controlledChanges: XCSControlledChanges?
}
