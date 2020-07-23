public typealias XCSBuildArgument = String

///
public struct XCSConfiguration: Codable {
    public enum CleanSchedule: Int, Codable {
        case never = 0
        case always = 1
        case daily = 2
        case weekly = 3
    }
    
    public enum CodeCoveragePreference: Int, Codable {
        case disabled = 0
        case enabled = 1
        case useSchemeSetting = 2
    }
    
    public enum BotSchedule: Int, Codable {
        case periodic = 1
        case onCommit = 2
        case manual = 3
    }
    
    /// Intervals available for a `periodic` `BotSchedule`.
    public enum PeriodicScheduleInterval: Int, Codable {
        case none = 0
        case hourly = 1
        case daily = 2
        case weekly = 3
        case integration = 4
    }
    
    // MARK: - Options
    
    ///
    public var schemeName: String?
    ///
    public var builtFromClean: CleanSchedule?
    ///
    public var disableAppThinning: Bool?
    ///
    public var codeCoveragePreference: CodeCoveragePreference?
    ///
    public var useParallelDeviceTesting: Bool?
    ///
    public var performsArchiveAction: Bool?
    ///
    public var performsAnalyzeAction: Bool?
    ///
    public var exportsProductFromArchive: Bool?
    
    // MARK: - Testing
    
    ///
    public var performsTestAction: Bool?
    ///
    public var runOnlyDisabledTests: Bool?
    ///
    public var testingDestinationType: Int?
    ///
    public var testLocalizations: [XCSTestLocalization]?
    
    // MARK: - Schedule
    
    ///
    public var scheduleType: BotSchedule?
    ///
    public var periodicScheduleInterval: PeriodicScheduleInterval
    ///
    public var weeklyScheduleDay: Int?
    ///
    public var hourOfIntegration: Int?
    ///
    public var minutesAfterHourToIntegrate: Int?
    ///
    public var performsUpgradeIntegration: Bool?
    
    // MARK: - Additional Configuration
    
    ///
    public var archiveExportOptions: XCSArchiveExportOptions?
    ///
    public var additionalBuildArguments: [XCSBuildArgument]?
    ///
    public var buildEnvironmentVariables: [String : String]?
    ///
    public var deviceSpecification: XCSDeviceSpecification?
    ///
    public var provisioningConfiguration: XCSProvisioningConfiguration?
    ///
    public var sourceControlBlueprint: XCSRepositoryBlueprint?
    ///
    public var triggers: [XCSTrigger]?
}

// MARK: - Equatable
extension XCSConfiguration: Equatable {
}

// MARK: - Hashable
extension XCSConfiguration: Hashable {
}
