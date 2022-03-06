import XcodeServer
import CoreDataPlus
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Configuration)
class Configuration: NSManagedObject {

}

extension Configuration {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: "Configuration")
    }

    @NSManaged var additionalBuildArgumentsData: Data?
    @NSManaged var addMissingDeviceToTeams: Bool
    @NSManaged var buildEnvironmentVariablesData: Data?
    @NSManaged var cleanScheduleRawValue: Int16
    @NSManaged var codeCoveragePreferenceRawValue: Int16
    @NSManaged var disableAppThinning: Bool
    @NSManaged var exportsProductFromArchive: Bool
    @NSManaged var hourOfIntegration: Int16
    @NSManaged var manageCertsAndProfiles: Bool
    @NSManaged var minutesAfterHourToIntegrate: Int16
    @NSManaged var performsAnalyzeAction: Bool
    @NSManaged var performsArchiveAction: Bool
    @NSManaged var performsTestAction: Bool
    @NSManaged var performsUpgradeIntegration: Bool
    @NSManaged var periodicScheduleIntervalRawValue: Int16
    @NSManaged var runOnlyDisabledTests: Bool
    @NSManaged var scheduleTypeRawValue: Int16
    @NSManaged var schemeName: String?
    @NSManaged var testingDestinationTypeRawValue: Int16
    @NSManaged var useParallelDeviceTesting: Bool
    @NSManaged var weeklyScheduleDay: Int16
    @NSManaged var bot: Bot?
    @NSManaged var deviceSpecification: DeviceSpecification?
    @NSManaged var repositories: NSSet?
    @NSManaged var triggers: NSSet?

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

extension Configuration {
    private static var jsonEncoder: JSONEncoder = JSONEncoder()
    private static var jsonDecoder: JSONDecoder = JSONDecoder()
    
    var codeCoveragePreference: XcodeServer.Bot.Coverage {
        get {
            return XcodeServer.Bot.Coverage(rawValue: Int(codeCoveragePreferenceRawValue)) ?? .disabled
        }
        set {
            codeCoveragePreferenceRawValue = Int16(newValue.rawValue)
        }
    }
    
    var cleanSchedule: XcodeServer.Bot.Cleaning {
        get {
            return XcodeServer.Bot.Cleaning(rawValue: Int(cleanScheduleRawValue)) ?? .never
        }
        set {
            cleanScheduleRawValue = Int16(newValue.rawValue)
        }
    }
    
    var scheduleType: XcodeServer.Bot.Schedule {
        get {
            return XcodeServer.Bot.Schedule(rawValue: Int(scheduleTypeRawValue)) ?? .periodic
        }
        set {
            scheduleTypeRawValue = Int16(newValue.rawValue)
        }
    }
    
    var periodicScheduleInterval: XcodeServer.Bot.PeriodicInterval {
        get {
            return XcodeServer.Bot.PeriodicInterval(rawValue: Int(periodicScheduleIntervalRawValue)) ?? .none
        }
        set {
            periodicScheduleIntervalRawValue = Int16(newValue.rawValue)
        }
    }
    
    var additionalBuildArguments: [String] {
        get {
            guard let data = additionalBuildArgumentsData else {
                return []
            }
            
            do {
                return try Self.jsonDecoder.decode([String].self, from: data)
            } catch {
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
                return []
            }
        }
        set {
            do {
                additionalBuildArgumentsData = try Self.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
            }
        }
    }
    
    var buildEnvironmentVariables: [String: String] {
        get {
            guard let data = buildEnvironmentVariablesData else {
                return [:]
            }
            
            do {
                return try Self.jsonDecoder.decode([String: String].self, from: data)
            } catch {
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
                return [:]
            }
        }
        set {
            do {
                buildEnvironmentVariablesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("", metadata: ["localizedDescription": .string(error.localizedDescription)])
            }
        }
    }
    
    var provisioning: XcodeServer.Bot.Configuration.Provisioning {
        get {
            var provisioning = XcodeServer.Bot.Configuration.Provisioning()
            provisioning.addMissingDevicesToTeams = addMissingDeviceToTeams
            provisioning.manageCertsAndProfiles = manageCertsAndProfiles
            return provisioning
        }
        set {
            addMissingDeviceToTeams = newValue.addMissingDevicesToTeams
            manageCertsAndProfiles = newValue.manageCertsAndProfiles
        }
    }
}

extension Configuration {
    func update(_ configuration: XcodeServer.Bot.Configuration, context: NSManagedObjectContext) {
        if deviceSpecification == nil {
            PersistentContainer.logger.info("Creating DEVICE_SPECIFICATION for Configuration '\(bot?.name ?? "")'")
            deviceSpecification = context.make()
        }
        
        additionalBuildArguments = configuration.buildArguments
        buildEnvironmentVariables = configuration.environmentVariables
        cleanSchedule = configuration.cleaning
        codeCoveragePreference = configuration.coverage
        disableAppThinning = configuration.disableAppThinning
        exportsProductFromArchive = configuration.exportsProduct
        hourOfIntegration = Int16(configuration.hourOfIntegration)
        minutesAfterHourToIntegrate = Int16(configuration.minutesAfterHourToIntegrate)
        performsAnalyzeAction = configuration.performsAnalyze
        performsArchiveAction = configuration.performsArchive
        performsTestAction = configuration.performsTest
        performsUpgradeIntegration = configuration.performsUpgradeIntegration
        periodicScheduleInterval = configuration.periodicInterval
        provisioning = configuration.provisioning
        runOnlyDisabledTests = configuration.runOnlyDisabledTests
        scheduleType = configuration.schedule
        useParallelDeviceTesting = configuration.useParallelDevices
        weeklyScheduleDay = Int16(configuration.weeklyScheduleDay)
        schemeName = configuration.schemeName
        deviceSpecification?.update(configuration.deviceSpecification, context: context)
        
        (triggers as? Set<Trigger>)?.forEach({ context.delete($0) })
        configuration.triggers.forEach { (trigger) in
            PersistentContainer.logger.info("Creating TRIGGER for Configuration '\(bot?.name ?? "")'")
            let _trigger: Trigger = context.make()
            _trigger.update(trigger, context: context)
            addToTriggers(_trigger)
        }
        
        let remoteId = configuration.sourceControlBlueprint.primaryRemoteIdentifier
        if !remoteId.isEmpty {
            let repository: Repository
            if let entity = Repository.repository(remoteId, in: context) {
                repository = entity
            } else {
                PersistentContainer.logger.info("Creating REPOSITORY '\(configuration.sourceControlBlueprint.name)' [\(remoteId)]")
                repository = context.make()
            }
            
            if repositories == nil || repositories?.contains(repository) == false {
                addToRepositories(repository)
            }
            
            repository.update(configuration.sourceControlBlueprint, context: context)
        }
    }
}

extension XcodeServer.Bot.Configuration {
    init(_ configuration: Configuration) {
        self.init()
        schedule = configuration.scheduleType
        periodicInterval = configuration.periodicScheduleInterval
        weeklyScheduleDay = Int(configuration.weeklyScheduleDay)
        hourOfIntegration = Int(configuration.hourOfIntegration)
        minutesAfterHourToIntegrate = Int(configuration.minutesAfterHourToIntegrate)
        schemeName = configuration.schemeName ?? ""
        cleaning = configuration.cleanSchedule
        disableAppThinning = configuration.disableAppThinning
        coverage = configuration.codeCoveragePreference
        useParallelDevices = configuration.useParallelDeviceTesting
        performsArchive = configuration.performsArchiveAction
        performsAnalyze = configuration.performsAnalyzeAction
        performsTest = configuration.performsTestAction
        performsUpgradeIntegration = configuration.performsUpgradeIntegration
        exportsProduct = configuration.exportsProductFromArchive
        runOnlyDisabledTests = configuration.runOnlyDisabledTests
        buildArguments = configuration.additionalBuildArguments
        environmentVariables = configuration.buildEnvironmentVariables
        provisioning = configuration.provisioning
        if let specification = configuration.deviceSpecification {
            deviceSpecification = XcodeServer.Device.Specification(specification)
        }
        if let triggers = configuration.triggers as? Set<Trigger> {
            self.triggers = triggers.map { XcodeServer.Trigger($0) }
        }
    }
}
#endif
