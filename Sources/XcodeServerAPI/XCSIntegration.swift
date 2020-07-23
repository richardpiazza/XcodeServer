import Foundation

/// A single run of a bot.
///
/// Integrations consist of building, analyzing, testing, and archiving the apps (or other software products) defined in
/// your Xcode projects.
public struct XCSIntegration: Codable {
    
    /// Current state of the `Integration` as it moves through the lifecycle.
    ///
    /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
    ///
    /// ```js
    /// // Integration step types
    /// XCSIntegrationStepTypePending: 'pending',
    /// XCSIntegrationStepTypePreparing: 'preparing',
    /// XCSIntegrationStepTypeCheckout: 'checkout',
    /// XCSIntegrationStepTypeTriggers: 'triggers',
    /// XCSIntegrationStepTypeBuilding: 'building',
    /// XCSIntegrationStepTypeProcessing: 'processing',
    /// XCSIntegrationStepTypeUploading: 'uploading',
    /// XCSIntegrationStepTypeCompleted: 'completed',
    /// ```
    public enum IntegrationStep: String, Codable {
        case pending
        case preparing
        case checkout
        case beforeTriggers = "before-triggers"
        case triggers
        case building
        case testing
        case archiving
        case processing
        case uploading
        case completed
    }
    
    /// The outcome of the `Integration`.
    ///
    /// /Applications/Xcode.app/Contents/Developer/usr/share/xcs/xcsd/constants.js
    ///
    /// ```js
    /// // Integration results
    /// XCSIntegrationResultSucceeded: 'succeeded',
    /// XCSIntegrationResultBuildErrors: 'build-errors',
    /// XCSIntegrationResultTestFailures: 'test-failures',
    /// XCSIntegrationResultWarnings: 'warnings',
    /// XCSIntegrationResultAnalyzerWarnings: 'analyzer-warnings',
    /// XCSIntegrationResultCanceled: 'canceled',
    /// XCSIntegrationResultInternalError: 'internal-error',
    /// ```
    public enum IntegrationResult: String, Codable {
        case analyzerWarnings = "analyzer-warnings"
        case buildErrors = "build-errors"
        case buildFailed = "build-failed"
        case canceled
        case checkoutError = "checkout-error"
        case internalError = "internal-error"
        case internalBuildError = "internal-build-error"
        case succeeded
        case testFailures = "test-failures"
        case triggerError = "trigger-error"
        case warnings
        case unknown
    }
    
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
    ///
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
    ///
    public var perfMetricKeyPaths: [String]?
    ///
    public var perfMetricNames: [String]?
    /// Timestamp of when the integration was first requests.
    public var queuedDate: Date?
    /// Overall result of the integration.
    public var result: IntegrationResult
    ///
    public var revisionBlueprint: XCSRepositoryBlueprint?
    ///
    public var shouldClean: Bool?
    /// Timestamp of when the integration began processing.
    public var startedTime: Date?
    /// The number of successful integrations in a row.
    public var successStreak: Int32?
    ///
    public var tags: [String]?
    /// Devices used to perform unit/ui testing
    public var testedDevices: [XCSDevice]?
    /// Unit/UI Test results
    public var testHierarchy: XCSTests?
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
