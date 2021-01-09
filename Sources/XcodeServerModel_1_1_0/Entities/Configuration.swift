import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(Configuration)
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

public extension Configuration {
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
                InternalLog.coreData.error("", error: error)
                return []
            }
        }
        set {
            do {
                additionalBuildArgumentsData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.coreData.error("", error: error)
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
                InternalLog.coreData.error("", error: error)
                return [:]
            }
        }
        set {
            do {
                buildEnvironmentVariablesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.coreData.error("", error: error)
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

public extension Configuration {
    func update(_ configuration: XcodeServer.Bot.Configuration, context: NSManagedObjectContext) {
        if deviceSpecification == nil {
            InternalLog.coreData.debug("Creating DEVICE_SPECIFICATION for Configuration '\(bot?.name ?? "")'")
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
            InternalLog.coreData.debug("Creating TRIGGER for Configuration '\(bot?.name ?? "")'")
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
                InternalLog.coreData.info("Creating REPOSITORY '\(configuration.sourceControlBlueprint.name)' [\(remoteId)]")
                repository = context.make()
            }
            
            if repositories == nil || repositories?.contains(repository) == false {
                addToRepositories(repository)
            }
            
            repository.update(configuration.sourceControlBlueprint, context: context)
        }
    }
}

public extension XcodeServer.Bot.Configuration {
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
