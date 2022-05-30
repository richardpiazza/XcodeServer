import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedConfiguration: NSManagedObject {

}

extension ManagedConfiguration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedConfiguration> {
        return NSFetchRequest<ManagedConfiguration>(entityName: "ManagedConfiguration")
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
    @NSManaged public var bot: ManagedBot?
    @NSManaged public var deviceSpecification: ManagedDeviceSpecification?
    @NSManaged public var repositories: NSSet?
    @NSManaged public var triggers: NSSet?

}

// MARK: Generated accessors for repositories
extension ManagedConfiguration {

    @objc(addRepositoriesObject:)
    @NSManaged public func addToRepositories(_ value: ManagedRepository)

    @objc(removeRepositoriesObject:)
    @NSManaged public func removeFromRepositories(_ value: ManagedRepository)

    @objc(addRepositories:)
    @NSManaged public func addToRepositories(_ values: NSSet)

    @objc(removeRepositories:)
    @NSManaged public func removeFromRepositories(_ values: NSSet)

}

// MARK: Generated accessors for triggers
extension ManagedConfiguration {

    @objc(addTriggersObject:)
    @NSManaged public func addToTriggers(_ value: ManagedTrigger)

    @objc(removeTriggersObject:)
    @NSManaged public func removeFromTriggers(_ value: ManagedTrigger)

    @objc(addTriggers:)
    @NSManaged public func addToTriggers(_ values: NSSet)

    @objc(removeTriggers:)
    @NSManaged public func removeFromTriggers(_ values: NSSet)

}

extension ManagedConfiguration {
    var codeCoveragePreference: Bot.Coverage {
        get { Bot.Coverage(rawValue: Int(codeCoveragePreferenceRawValue)) ?? .disabled }
        set { codeCoveragePreferenceRawValue = Int16(newValue.rawValue) }
    }
    
    var cleanSchedule: Bot.Cleaning {
        get { Bot.Cleaning(rawValue: Int(cleanScheduleRawValue)) ?? .never }
        set { cleanScheduleRawValue = Int16(newValue.rawValue) }
    }
    
    var scheduleType: Bot.Schedule {
        get { Bot.Schedule(rawValue: Int(scheduleTypeRawValue)) ?? .periodic }
        set { scheduleTypeRawValue = Int16(newValue.rawValue) }
    }
    
    var periodicScheduleInterval: Bot.PeriodicInterval {
        get { Bot.PeriodicInterval(rawValue: Int(periodicScheduleIntervalRawValue)) ?? .never }
        set { periodicScheduleIntervalRawValue = Int16(newValue.rawValue) }
    }
    
    var additionalBuildArguments: [String] {
        get {
            guard let data = additionalBuildArgumentsData else {
                return []
            }
            
            do {
                return try PersistentContainer.jsonDecoder.decode([String].self, from: data)
            } catch {
                PersistentContainer.logger.error("Failed to decode 'additionalBuildArgumentsData'.", metadata: [
                    "UTF8": .string(String(data: data, encoding: .utf8) ?? ""),
                    "localizedDescription": .string(error.localizedDescription)
                ])
                return []
            }
        }
        set {
            do {
                additionalBuildArgumentsData = try PersistentContainer.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("Failed to encode 'additionalBuildArgumentsData'.", metadata: [
                    "UTF8": .stringConvertible(newValue),
                    "localizedDescription": .string(error.localizedDescription)
                ])
            }
        }
    }
    
    var buildEnvironmentVariables: [String: String] {
        get {
            guard let data = buildEnvironmentVariablesData else {
                return [:]
            }
            
            do {
                return try PersistentContainer.jsonDecoder.decode([String: String].self, from: data)
            } catch {
                PersistentContainer.logger.error("Failed to decode 'buildEnvironmentVariablesData'.", metadata: [
                    "UTF8": .string(String(data: data, encoding: .utf8) ?? ""),
                    "localizedDescription": .string(error.localizedDescription)
                ])
                return [:]
            }
        }
        set {
            do {
                buildEnvironmentVariablesData = try PersistentContainer.jsonEncoder.encode(newValue)
            } catch {
                PersistentContainer.logger.error("Failed to encode 'buildEnvironmentVariablesData'.", metadata: [
                    "UTF8": .stringConvertible(newValue),
                    "localizedDescription": .string(error.localizedDescription)
                ])
            }
        }
    }
    
    var provisioning: Bot.Configuration.Provisioning {
        get {
            var provisioning = Bot.Configuration.Provisioning()
            provisioning.addMissingDevicesToTeams = addMissingDeviceToTeams
            provisioning.manageCertsAndProfiles = manageCertsAndProfiles
            return provisioning
        }
        set {
            addMissingDeviceToTeams = newValue.addMissingDevicesToTeams
            manageCertsAndProfiles = newValue.manageCertsAndProfiles
        }
    }
    
    func update(_ configuration: Bot.Configuration, context: NSManagedObjectContext) {
        if deviceSpecification == nil {
            PersistentContainer.logger.trace("Creating `ManagedDeviceSpecification`.", metadata: [
                "Bot.ID": .string(bot?.identifier ?? ""),
                "Bot.Name": .string(bot?.name ?? "")
            ])
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
        
        (triggers as? Set<ManagedTrigger>)?.forEach({ context.delete($0) })
        configuration.triggers.forEach { (trigger) in
            PersistentContainer.logger.trace("Creating `ManagedTrigger`.", metadata: [
                "Bot.ID": .string(bot?.identifier ?? ""),
                "Bot.Name": .string(bot?.name ?? "")
            ])
            let _trigger: ManagedTrigger = context.make()
            _trigger.update(trigger, context: context)
            addToTriggers(_trigger)
        }
        
        let remoteId = configuration.sourceControlBlueprint.primaryRemoteIdentifier
        if !remoteId.isEmpty {
            let repository: ManagedRepository
            if let entity = ManagedRepository.repository(remoteId, in: context) {
                repository = entity
            } else {
                PersistentContainer.logger.trace("Creating `ManagedRepository`.", metadata: [
                    "Remote.ID": .string(remoteId),
                    "Blueprint.ID": .string(configuration.sourceControlBlueprint.id),
                    "Blueprint.Name": .string(configuration.sourceControlBlueprint.name),
                ])
                repository = context.make()
            }
            
            if repositories == nil || repositories?.contains(repository) == false {
                addToRepositories(repository)
            }
            
            repository.update(configuration.sourceControlBlueprint, context: context)
        }
    }
}

extension Bot.Configuration {
    init(_ configuration: ManagedConfiguration) {
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
            deviceSpecification = Device.Specification(specification)
        }
        if let triggers = configuration.triggers as? Set<ManagedTrigger> {
            self.triggers = triggers.map { Trigger($0) }
        }
    }
}
#endif
