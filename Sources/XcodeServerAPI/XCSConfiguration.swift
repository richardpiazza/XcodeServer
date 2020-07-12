import XcodeServerCommon

public typealias XCSBuildArgument = String

public struct XCSConfiguration: Codable {
    public var schemeName: String?
    
    // Options
    public var builtFromClean: CleanSchedule?
    public var disableAppThinning: Bool?
    public var codeCoveragePreference: CodeCoveragePreference?
    public var useParallelDeviceTesting: Bool?
    public var performsArchiveAction: Bool?
    public var performsAnalyzeAction: Bool?
    public var exportsProductFromArchive: Bool?
    
    // Testing
    public var performsTestAction: Bool?
    public var runOnlyDisabledTests: Bool?
    public var testingDestinationType: Int?
    public var testLocalizations: [XCSTestLocalization]?
    
    // Schedule
    public var scheduleType: BotSchedule?
    public var periodicScheduleInterval: PeriodicScheduleInterval
    public var weeklyScheduleDay: Int?
    public var hourOfIntegration: Int?
    public var minutesAfterHourToIntegrate: Int?
    public var performsUpgradeIntegration: Bool?
    
    // Additional Configuration
    public var archiveExportOptions: XCSArchiveExportOptions?
    public var additionalBuildArguments: [XCSBuildArgument]?
    public var buildEnvironmentVariables: [String : String]?
    public var deviceSpecification: XCSDeviceSpecification?
    public var provisioningConfiguration: XCSProvisioningConfiguration?
    public var sourceControlBlueprint: XCSRepositoryBlueprint?
    public var triggers: [XCSTrigger]?
}
