import Foundation
import XcodeServerCommon

/// A single run of a bot.
///
/// Integrations consist of building, analyzing, testing, and archiving the apps (or other software products) defined in
/// your Xcode projects.
public struct XCSIntegration: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case assets
        case bot
        case buildResultSummary
        case buildServiceFingerprint
        case ccPercentage
        case ccPercentageDelta
        case controlledChanges
        case currentStep
        case docType = "doc_type"
        case duration
        case endedTime
        case number
        case queuedDate
        case result
        case revisionBlueprint
        case shouldClean
        case startedTime
        case successStreak = "success_streak"
        case tags
        case testedDevices
        case testHierarchy
    }
    
    // MARK: - Document
    
    /// Document ID
    public var _id: String = ""
    /// Document Revision
    public var _rev: String = ""
    /// Document Type
    public var docType: String = "integration"
    
    // MARK: - Properties
    
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

// MARK: - Identifiable
extension XCSIntegration: Identifiable {
    public var id: String {
        get { _id }
        set { _id = newValue }
    }
}

// MARK: - Deprecations
public extension XCSIntegration {
    @available(*, deprecated, renamed: "id")
    var identifier: String {
        get { _id }
        set { _id = newValue }
    }
}
