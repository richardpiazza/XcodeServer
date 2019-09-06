import Foundation
import CoreData
import XcodeServerCommon

@objc(Configuration)
public class Configuration: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, bot: Bot) {
        self.init(managedObjectContext: managedObjectContext)
        self.bot = bot
        self.deviceSpecification = DeviceSpecification(managedObjectContext: managedObjectContext, configuration: self)
        self.codeCoveragePreferenceRawValue = 0
        self.cleanScheduleRawValue = 0
        self.disableAppThinning = false
        self.useParallelDeviceTesting = false
        self.performsAnalyzeAction = false
        self.performsArchiveAction = false
        self.performsTestAction = false
        self.exportsProductFromArchive = false
        self.runOnlyDisabledTests = false
        self.testingDestinationTypeRawValue = 0
        self.scheduleTypeRawValue = 0
        self.periodicScheduleIntervalRawValue = 0
        self.weeklyScheduleDay = 0
        self.hourOfIntegration = 0
        self.minutesAfterHourToIntegrate = 0
        self.performsUpgradeIntegration = false
        self.addMissingDeviceToTeams = false
        self.manageCertsAndProfiles = false
    }
}

// MARK: - CoreData Properties
public extension Configuration {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: entityName)
    }
    
    @NSManaged var additionalBuildArgumentsData: Data?
    @NSManaged var addMissingDeviceToTeams: Bool // XCSProvisioningConfiguration
    @NSManaged var bot: Bot?
    @NSManaged var buildEnvironmentVariablesData: Data?
    @NSManaged var codeCoveragePreferenceRawValue: Int16
    @NSManaged var cleanScheduleRawValue: Int16
    @NSManaged var deviceSpecification: DeviceSpecification?
    @NSManaged var disableAppThinning: Bool
    @NSManaged var exportsProductFromArchive: Bool
    @NSManaged var hourOfIntegration: Int16
    @NSManaged var manageCertsAndProfiles: Bool // XCSProvisioningConfiguration
    @NSManaged var minutesAfterHourToIntegrate: Int16
    @NSManaged var periodicScheduleIntervalRawValue: Int16
    @NSManaged var performsAnalyzeAction: Bool
    @NSManaged var performsArchiveAction: Bool
    @NSManaged var performsTestAction: Bool
    @NSManaged var performsUpgradeIntegration: Bool
    @NSManaged var repositories: Set<Repository>?
    @NSManaged var runOnlyDisabledTests: Bool
    @NSManaged var scheduleTypeRawValue: Int16
    @NSManaged var schemeName: String?
    @NSManaged var testingDestinationTypeRawValue: Int16
    @NSManaged var triggers: Set<Trigger>?
    @NSManaged var useParallelDeviceTesting: Bool
    @NSManaged var weeklyScheduleDay: Int16
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

public extension Configuration {
    var codeCoveragePreference: CodeCoveragePreference {
        get {
            return CodeCoveragePreference(rawValue: Int(codeCoveragePreferenceRawValue)) ?? .disabled
        }
        set {
            codeCoveragePreferenceRawValue = Int16(newValue.rawValue)
        }
    }
    
    var cleanSchedule: CleanSchedule {
        get {
            return CleanSchedule(rawValue: Int(cleanScheduleRawValue)) ?? .never
        }
        set {
            cleanScheduleRawValue = Int16(newValue.rawValue)
        }
    }
    
    var scheduleType: BotSchedule {
        get {
            return BotSchedule(rawValue: Int(scheduleTypeRawValue)) ?? .periodic
        }
        set {
            scheduleTypeRawValue = Int16(newValue.rawValue)
        }
    }
    
    var periodicScheduleInterval: PeriodicScheduleInterval {
        get {
            return PeriodicScheduleInterval(rawValue: Int(periodicScheduleIntervalRawValue)) ?? .none
        }
        set {
            periodicScheduleIntervalRawValue = Int16(newValue.rawValue)
        }
    }
}
