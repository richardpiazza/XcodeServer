import XcodeServerCommon

public typealias XCSBuildArgument = String

////
public struct XCSConfiguration: Codable {
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
