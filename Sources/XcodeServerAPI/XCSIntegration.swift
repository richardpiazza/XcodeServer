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
    /// The associated bot.
    public var bot: XCSBot?
    /// A summary of the build errors & warnings encountered during the integration.
    public var buildResultSummary: XCSBuildResultSummary?
    public var buildServiceFingerprint: String?
    /// The overall 'Code Coverage' percentage.
    public var ccPercentage: Int?
    /// The change in 'Code Coverage' since the last integration.
    public var ccPercentageDelta: Int?
    /// File changes that are tracked as part of this integration.
    public var controlledChanges: XCSControlledChanges?
    /// The progress of the integration.
    public var currentStep: IntegrationStep
    /// The length of time (in seconds) the integration took to complete.
    public var duration: Double?
    /// Timestamp of when the integration completed.
    public var endedTime: Date?
    /// THe integration counter.
    public var number: Int32
    public var perfMetricKeyPaths: [String]?
    public var perfMetricNames: [String]?
    /// Timestamp of when the integration was first requests.
    public var queuedDate: Date?
    /// Overall result of the integration.
    public var result: IntegrationResult
    public var revisionBlueprint: XCSRepositoryBlueprint?
    public var shouldClean: Bool?
    /// Timestamp of when the integration began processing.
    public var startedTime: Date?
    /// The number of successful integrations in a row.
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
