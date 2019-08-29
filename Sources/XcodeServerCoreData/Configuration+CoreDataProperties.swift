import Foundation
import CoreData

public extension Configuration {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: "Configuration")
    }
    
    @NSManaged public var builtFromClean: NSNumber?
    @NSManaged public var codeCoveragePreference: NSNumber?
    @NSManaged public var hourOfIntegration: NSNumber?
    @NSManaged public var minutesAfterHourToIntegrate: NSNumber?
    @NSManaged public var performsAnalyzeAction: NSNumber?
    @NSManaged public var performsArchiveAction: NSNumber?
    @NSManaged public var performsTestAction: NSNumber?
    @NSManaged public var periodicScheduleInterval: NSNumber?
    @NSManaged public var scheduleType: NSNumber?
    @NSManaged public var schemeName: String?
    @NSManaged public var testingDestinationType: NSNumber?
    @NSManaged public var weeklyScheduleDay: NSNumber?
    @NSManaged public var disableAppThinning: NSNumber?
    @NSManaged public var useParallelDeviceTesting: NSNumber?
    @NSManaged public var exportsProductFromArchive: NSNumber?
    @NSManaged public var runOnlyDisabledTests: NSNumber?
    @NSManaged public var testingDestinationTypeRawValue: NSNumber?
    @NSManaged public var performsUpgradeIntegration: NSNumber?
    @NSManaged public var addMissingDeviceToTeams: NSNumber?
    @NSManaged public var manageCertsAndProfiles: NSNumber?
    @NSManaged public var additionalBuildArgumentsData: Data?
    @NSManaged public var buildEnvironmentVariablesData: Data?
    @NSManaged public var bot: Bot?
    @NSManaged public var deviceSpecification: DeviceSpecification?
    @NSManaged public var repositories: Set<Repository>?
    @NSManaged public var triggers: Set<Trigger>?
    
}

// MARK: Generated accessors for repositories
extension Configuration {
    
    @objc(addRepositoriesObject:)
    @NSManaged public func addToRepositories(_ value: Repository)
    
    @objc(removeRepositoriesObject:)
    @NSManaged public func removeFromRepositories(_ value: Repository)
    
    @objc(addRepositories:)
    @NSManaged public func addToRepositories(_ values: Set<Repository>)
    
    @objc(removeRepositories:)
    @NSManaged public func removeFromRepositories(_ values: Set<Repository>)
    
}

// MARK: Generated accessors for triggers
extension Configuration {
    
    @objc(addTriggersObject:)
    @NSManaged public func addToTriggers(_ value: Trigger)
    
    @objc(removeTriggersObject:)
    @NSManaged public func removeFromTriggers(_ value: Trigger)
    
    @objc(addTriggers:)
    @NSManaged public func addToTriggers(_ values: Set<Trigger>)
    
    @objc(removeTriggers:)
    @NSManaged public func removeFromTriggers(_ values: Set<Trigger>)
    
}
