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
                InternalLog.error("", error: error)
                return []
            }
        }
        set {
            do {
                additionalBuildArgumentsData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.error("", error: error)
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
                InternalLog.error("", error: error)
                return [:]
            }
        }
        set {
            do {
                buildEnvironmentVariablesData = try Self.jsonEncoder.encode(newValue)
            } catch {
                InternalLog.error("", error: error)
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
        
        triggers?.forEach({ context.delete($0) })
        configuration.triggers.forEach { (trigger) in
            let _trigger = XcodeServerCoreData.Trigger(context: context)
            _trigger.update(trigger, context: context)
            _trigger.configuration = self
        }
        
        let remoteId = configuration.sourceControlBlueprint.primaryRemoteIdentifier
        if !remoteId.isEmpty {
            let _repository: Repository
            if let entity = repositories?.first(where: { $0.identifier == remoteId }) {
                _repository = entity
            } else {
                _repository = Repository(context: context)
                addToRepositories(_repository)
            }
            
            _repository.update(configuration.sourceControlBlueprint, context: context)
        }
    }
}
#endif
