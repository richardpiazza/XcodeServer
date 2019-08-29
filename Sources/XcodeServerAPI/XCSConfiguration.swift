import Foundation

public struct XCSConfiguration: Codable {
    public var schemeName: String?
    
    // Options
    public var builtFromClean: XCSCleanSchedule?
    public var disableAppThinning: Bool?
    public var codeCoveragePreference: XCSCodeCoveragePreference?
    public var useParallelDeviceTesting: Bool?
    public var performsArchiveAction: Bool?
    public var performsAnalyzeAction: Bool?
    public var exportsProductFromArchive: Bool?
    
    // Testing
    public var performsTestAction: Bool?
    public var runOnlyDisabledTests: Bool?
    public var testingDestinationType: Int?
    public var testLocalizations: [XCSTestLocalzation]?
    
    // Schedule
    public var scheduleType: XCSBotSchedule?
    public var periodicScheduleInterval: XCSPeriodicScheduleInterval
    public var weeklyScheduleDay: Int?
    public var hourOfIntegration: Int?
    public var minutesAfterHourToIntegrate: Int?
    public var performsUpgradeIntegration: Bool?
    
    // Additional Configuration
    public var buildEnvironmentVariables: [String : String]?
    public var additionalBuildArguments: [XCSBuildArgument]?
    public var provisioningConfiguration: XCSProvisioningConfiguration?
    public var deviceSpecification: XCSDeviceSpecification?
    public var sourceControlBlueprint: XCSRepositoryBlueprint?
    public var triggers: [XCSTrigger]?
}
