import XcodeServer
#if canImport(CoreData)
import CoreData

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
                print(error)
                return []
            }
        }
        set {
            do {
                additionalBuildArgumentsData = try Self.jsonEncoder.encode(newValue)
            } catch {
                print(error)
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
                print(error)
                return [:]
            }
        }
        set {
            do {
                buildEnvironmentVariablesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                print(error)
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

public extension XcodeServerCoreData.Configuration {
    func update(_ configuration: XcodeServer.Bot.Configuration, context: NSManagedObjectContext) {
        if deviceSpecification == nil {
            deviceSpecification = DeviceSpecification(context: context)
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
        
        triggers?.removeAll()
        configuration.triggers.forEach { (trigger) in
            let _trigger = XcodeServerCoreData.Trigger(context: context)
            _trigger.update(trigger, context: context)
            addToTriggers(_trigger)
        }
        
        let remoteId = configuration.sourceControlBlueprint.primaryRemoteIdentifier
        if !remoteId.isEmpty {
            if let entity = repositories?.first(where: { $0.identifier == remoteId }) {
                entity.update(configuration.sourceControlBlueprint, context: context)
            } else {
                let _repository = Repository(context: context)
                _repository.update(configuration.sourceControlBlueprint, context: context)
                addToRepositories(_repository)
            }
        }
    }
}

/*
 extension XcodeServerCoreData.Configuration {
     public func update(withConfiguration configuration: XCSConfiguration) {
         guard let moc = self.managedObjectContext else {
             return
         }
         
         self.schemeName = configuration.schemeName
         
         self.cleanSchedule = XcodeServer.Bot.Cleaning(rawValue: configuration.builtFromClean?.rawValue ?? 0) ?? .never
         self.disableAppThinning = configuration.disableAppThinning ?? false
         self.codeCoveragePreference = XcodeServer.Bot.Coverage(rawValue: configuration.codeCoveragePreference?.rawValue ?? 0) ?? .disabled
         self.useParallelDeviceTesting = configuration.useParallelDeviceTesting ?? false
         self.performsArchiveAction = configuration.performsArchiveAction ?? false
         self.performsAnalyzeAction = configuration.performsAnalyzeAction ?? false
         self.exportsProductFromArchive = configuration.exportsProductFromArchive ?? false
         self.performsTestAction = configuration.performsTestAction ?? false
         self.runOnlyDisabledTests = configuration.runOnlyDisabledTests ?? false
         self.testingDestinationTypeRawValue = Int16(configuration.testingDestinationType ?? 0)
         
         
         self.scheduleType = XcodeServer.Bot.Schedule(rawValue: configuration.scheduleType?.rawValue ?? 0) ?? .periodic
         self.periodicScheduleInterval = XcodeServer.Bot.PeriodicInterval(rawValue: configuration.periodicScheduleInterval.rawValue) ?? .none
         self.weeklyScheduleDay = Int16(configuration.weeklyScheduleDay ?? 0)
         self.hourOfIntegration = Int16(configuration.hourOfIntegration ?? 0)
         self.minutesAfterHourToIntegrate = Int16(configuration.minutesAfterHourToIntegrate ?? 0)
         self.performsUpgradeIntegration = configuration.performsUpgradeIntegration ?? false
         self.addMissingDeviceToTeams = configuration.provisioningConfiguration?.addMissingDevicesToTeams ?? false
         self.manageCertsAndProfiles = configuration.provisioningConfiguration?.manageCertsAndProfiles ?? false
         
         if let buildArgs = configuration.additionalBuildArguments {
             self.additionalBuildArguments = buildArgs
         }
         
         if let envVars = configuration.buildEnvironmentVariables {
             self.buildEnvironmentVariables = envVars
         }
         
         // Repositories
         if let configurationBlueprint = configuration.sourceControlBlueprint {
             if let repositories = self.repositories {
                 for repository in repositories {
                     let _ = repository.configurations?.remove(self)
                 }
             }
             
             if let remoteRepositories = configurationBlueprint.remoteRepositories {
                 for remoteRepository in remoteRepositories {
                     guard let identifier = remoteRepository.identifier else {
                         continue
                     }
                     
                     let repo: Repository
                     if let r = moc.repository(withIdentifier: identifier) {
                         repo = r
                     } else {
                         repo = Repository(context: moc)
                         repo.identifier = identifier
                     }
                     
                     repo.update(withRevisionBlueprint: configurationBlueprint)
                     
                     if let repositories = self.repositories {
                         if !repositories.contains(repo) {
                             self.repositories?.insert(repo)
                         }
                     }
                 }
             }
         }
         
         // Device Specification
         if let configurationDeviceSpecification = configuration.deviceSpecification {
             self.deviceSpecification?.update(withDeviceSpecification: configurationDeviceSpecification)
         }
         
         // Triggers
         if let triggers = self.triggers {
             for trigger in triggers {
                 trigger.configuration = nil
                 moc.delete(trigger)
             }
         }
         
         if let configTriggers = configuration.triggers {
             for configurationTrigger in configTriggers {
                 let trigger = Trigger(context: moc)
                 trigger.configuration = self
                 trigger.update(withTrigger: configurationTrigger)
             }
         }
     }
 }

 */

#endif
