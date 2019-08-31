import Foundation
import CoreData

@objc(Configuration)
public class Configuration: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, bot: Bot) {
        self.init(managedObjectContext: managedObjectContext)
        self.bot = bot
        self.deviceSpecification = DeviceSpecification(managedObjectContext: managedObjectContext, configuration: self)
    }
}

// MARK: - CoreData Properties
public extension Configuration {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: entityName)
    }
    
    @NSManaged var builtFromClean: NSNumber?
    @NSManaged var codeCoveragePreference: NSNumber?
    @NSManaged var hourOfIntegration: NSNumber?
    @NSManaged var minutesAfterHourToIntegrate: NSNumber?
    @NSManaged var performsAnalyzeAction: NSNumber?
    @NSManaged var performsArchiveAction: NSNumber?
    @NSManaged var performsTestAction: NSNumber?
    @NSManaged var periodicScheduleInterval: NSNumber?
    @NSManaged var scheduleType: NSNumber?
    @NSManaged var schemeName: String?
    @NSManaged var testingDestinationType: NSNumber?
    @NSManaged var weeklyScheduleDay: NSNumber?
    @NSManaged var disableAppThinning: NSNumber?
    @NSManaged var useParallelDeviceTesting: NSNumber?
    @NSManaged var exportsProductFromArchive: NSNumber?
    @NSManaged var runOnlyDisabledTests: NSNumber?
    @NSManaged var testingDestinationTypeRawValue: NSNumber?
    @NSManaged var performsUpgradeIntegration: NSNumber?
    @NSManaged var addMissingDeviceToTeams: NSNumber?
    @NSManaged var manageCertsAndProfiles: NSNumber?
    @NSManaged var additionalBuildArgumentsData: Data?
    @NSManaged var buildEnvironmentVariablesData: Data?
    @NSManaged var bot: Bot?
    @NSManaged var deviceSpecification: DeviceSpecification?
    @NSManaged var repositories: Set<Repository>?
    @NSManaged var triggers: Set<Trigger>?
    
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
