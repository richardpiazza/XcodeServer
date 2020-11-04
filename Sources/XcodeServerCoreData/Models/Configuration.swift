import Foundation
#if canImport(CoreData)
import CoreData

@objc(Configuration)
public class Configuration: NSManagedObject {

}

extension Configuration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: "Configuration")
    }

    @NSManaged public var additionalBuildArgumentsData: Data?
    @NSManaged public var addMissingDeviceToTeams: Bool
    @NSManaged public var buildEnvironmentVariablesData: Data?
    @NSManaged public var cleanScheduleRawValue: Int16
    @NSManaged public var codeCoveragePreferenceRawValue: Int16
    @NSManaged public var disableAppThinning: Bool
    @NSManaged public var exportsProductFromArchive: Bool
    @NSManaged public var hourOfIntegration: Int16
    @NSManaged public var manageCertsAndProfiles: Bool
    @NSManaged public var minutesAfterHourToIntegrate: Int16
    @NSManaged public var performsAnalyzeAction: Bool
    @NSManaged public var performsArchiveAction: Bool
    @NSManaged public var performsTestAction: Bool
    @NSManaged public var performsUpgradeIntegration: Bool
    @NSManaged public var periodicScheduleIntervalRawValue: Int16
    @NSManaged public var runOnlyDisabledTests: Bool
    @NSManaged public var scheduleTypeRawValue: Int16
    @NSManaged public var schemeName: String?
    @NSManaged public var testingDestinationTypeRawValue: Int16
    @NSManaged public var useParallelDeviceTesting: Bool
    @NSManaged public var weeklyScheduleDay: Int16
    @NSManaged public var bot: Bot?
    @NSManaged public var deviceSpecification: DeviceSpecification?
    @NSManaged public var repositories: NSSet?
    @NSManaged public var triggers: NSSet?

}

// MARK: Generated accessors for repositories
extension Configuration {

    @objc(addRepositoriesObject:)
    @NSManaged public func addToRepositories(_ value: Repository)

    @objc(removeRepositoriesObject:)
    @NSManaged public func removeFromRepositories(_ value: Repository)

    @objc(addRepositories:)
    @NSManaged public func addToRepositories(_ values: NSSet)

    @objc(removeRepositories:)
    @NSManaged public func removeFromRepositories(_ values: NSSet)

}

// MARK: Generated accessors for triggers
extension Configuration {

    @objc(addTriggersObject:)
    @NSManaged public func addToTriggers(_ value: Trigger)

    @objc(removeTriggersObject:)
    @NSManaged public func removeFromTriggers(_ value: Trigger)

    @objc(addTriggers:)
    @NSManaged public func addToTriggers(_ values: NSSet)

    @objc(removeTriggers:)
    @NSManaged public func removeFromTriggers(_ values: NSSet)

}
#endif
