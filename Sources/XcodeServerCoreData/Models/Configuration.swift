import Foundation
#if canImport(CoreData)
import CoreData

@objc(Configuration)
public class Configuration: NSManagedObject {
    
    @NSManaged public var additionalBuildArgumentsData: Data?
    @NSManaged public var addMissingDeviceToTeams: Bool
    @NSManaged public var bot: Bot?
    @NSManaged public var buildEnvironmentVariablesData: Data?
    @NSManaged public var codeCoveragePreferenceRawValue: Int16
    @NSManaged public var cleanScheduleRawValue: Int16
    @NSManaged public var deviceSpecification: DeviceSpecification?
    @NSManaged public var disableAppThinning: Bool
    @NSManaged public var exportsProductFromArchive: Bool
    @NSManaged public var hourOfIntegration: Int16
    @NSManaged public var manageCertsAndProfiles: Bool
    @NSManaged public var minutesAfterHourToIntegrate: Int16
    @NSManaged public var periodicScheduleIntervalRawValue: Int16
    @NSManaged public var performsAnalyzeAction: Bool
    @NSManaged public var performsArchiveAction: Bool
    @NSManaged public var performsTestAction: Bool
    @NSManaged public var performsUpgradeIntegration: Bool
    @NSManaged public var repositories: Set<Repository>?
    @NSManaged public var runOnlyDisabledTests: Bool
    @NSManaged public var scheduleTypeRawValue: Int16
    @NSManaged public var schemeName: String?
    @NSManaged public var testingDestinationTypeRawValue: Int16
    @NSManaged public var triggers: Set<Trigger>?
    @NSManaged public var useParallelDeviceTesting: Bool
    @NSManaged public var weeklyScheduleDay: Int16
    
    @objc(addRepositoriesObject:)
    @NSManaged public func addToRepositories(_ value: Repository)
    
    @objc(removeRepositoriesObject:)
    @NSManaged public func removeFromRepositories(_ value: Repository)
    
    @objc(addRepositories:)
    @NSManaged public func addToRepositories(_ values: Set<Repository>)
    
    @objc(removeRepositories:)
    @NSManaged public func removeFromRepositories(_ values: Set<Repository>)
    
    @objc(addTriggersObject:)
    @NSManaged public func addToTriggers(_ value: Trigger)
    
    @objc(removeTriggersObject:)
    @NSManaged public func removeFromTriggers(_ value: Trigger)
    
    @objc(addTriggers:)
    @NSManaged public func addToTriggers(_ values: Set<Trigger>)
    
    @objc(removeTriggers:)
    @NSManaged public func removeFromTriggers(_ values: Set<Trigger>)
    
}

#endif
