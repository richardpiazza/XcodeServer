import Foundation

public extension Bot {
    
    struct Configuration: Hashable, Codable {
        public struct Provisioning: Hashable, Codable {
            public var addMissingDevicesToTeams: Bool
            public var manageCertsAndProfiles: Bool
            
            public init(addMissingDevicesToTeams: Bool = false, manageCertsAndProfiles: Bool = false) {
                self.addMissingDevicesToTeams = addMissingDevicesToTeams
                self.manageCertsAndProfiles = manageCertsAndProfiles
            }
        }
        
        public struct ArchiveExport: Hashable, Codable {
            public var created: Date
            public var options: ExportOptions
            
            public init(created: Date = Date(), options: Bot.Configuration.ExportOptions = ExportOptions()) {
                self.created = created
                self.options = options
            }
        }
        
        /// Parameters used during the export of a compiled/signed application.
        public struct ExportOptions: Hashable, Codable {
            
            public var method: String
            public var teamID: String
            public var uploadBitcode: Bool
            public var stripSwiftSymbols: Bool
            public var iCloudContainerEnvironment: String
            public var signingCertificate: String
            public var signingStyle: String
            public var uploadSymbols: Bool
            public var provisioningProfiles: ProvisioningProfiles
            
            public init(
                method: String = "",
                teamID: String = "",
                uploadBitcode: Bool = false,
                stripSwiftSymbols: Bool = false,
                iCloudContainerEnvironment: String = "",
                signingCertificate: String = "",
                signingStyle: String = "",
                uploadSymbols: Bool = false,
                provisioningProfiles: Bot.Configuration.ProvisioningProfiles = [:]
            ) {
                self.method = method
                self.teamID = teamID
                self.uploadBitcode = uploadBitcode
                self.stripSwiftSymbols = stripSwiftSymbols
                self.iCloudContainerEnvironment = iCloudContainerEnvironment
                self.signingCertificate = signingCertificate
                self.signingStyle = signingStyle
                self.uploadSymbols = uploadSymbols
                self.provisioningProfiles = provisioningProfiles
            }
        }
        
        public typealias ProvisioningProfiles = [String: String]
        
        // MARK: - Schedule
        public var schedule: Schedule
        public var periodicInterval: PeriodicInterval
        public var weeklyScheduleDay: Int
        public var hourOfIntegration: Int
        public var minutesAfterHourToIntegrate: Int
        
        // MARK: - Options
        public var schemeName: String
        public var cleaning: Cleaning
        public var disableAppThinning: Bool
        public var coverage: Coverage
        public var useParallelDevices: Bool
        public var performsArchive: Bool
        public var performsAnalyze: Bool
        public var performsTest: Bool
        public var performsUpgradeIntegration: Bool
        public var exportsProduct: Bool
        public var runOnlyDisabledTests: Bool
        public var buildArguments: [String]
        public var environmentVariables: [String : String]
        public var archiveExportOptions: ArchiveExport
        public var provisioning: Provisioning
        public var sourceControlBlueprint: SourceControl.Blueprint
        public var deviceSpecification: Device.Specification
        public var triggers: [Trigger]
        
        public init(
            schedule: Bot.Schedule = .manual,
            periodicInterval: Bot.PeriodicInterval = .never,
            weeklyScheduleDay: Int = 0,
            hourOfIntegration: Int = 0,
            minutesAfterHourToIntegrate: Int = 0,
            schemeName: String = "",
            cleaning: Bot.Cleaning = .never,
            disableAppThinning: Bool = false,
            coverage: Bot.Coverage = .useSchemeSetting,
            useParallelDevices: Bool = false,
            performsArchive: Bool = false,
            performsAnalyze: Bool = false,
            performsTest: Bool = false,
            performsUpgradeIntegration: Bool = false,
            exportsProduct: Bool = false,
            runOnlyDisabledTests: Bool = false,
            buildArguments: [String] = [],
            environmentVariables: [String : String] = [:],
            archiveExportOptions: Bot.Configuration.ArchiveExport = ArchiveExport(),
            provisioning: Bot.Configuration.Provisioning = Provisioning(),
            sourceControlBlueprint: SourceControl.Blueprint = SourceControl.Blueprint(),
            deviceSpecification: Device.Specification = Device.Specification(),
            triggers: [Trigger] = []
        ) {
            self.schedule = schedule
            self.periodicInterval = periodicInterval
            self.weeklyScheduleDay = weeklyScheduleDay
            self.hourOfIntegration = hourOfIntegration
            self.minutesAfterHourToIntegrate = minutesAfterHourToIntegrate
            self.schemeName = schemeName
            self.cleaning = cleaning
            self.disableAppThinning = disableAppThinning
            self.coverage = coverage
            self.useParallelDevices = useParallelDevices
            self.performsArchive = performsArchive
            self.performsAnalyze = performsAnalyze
            self.performsTest = performsTest
            self.performsUpgradeIntegration = performsUpgradeIntegration
            self.exportsProduct = exportsProduct
            self.runOnlyDisabledTests = runOnlyDisabledTests
            self.buildArguments = buildArguments
            self.environmentVariables = environmentVariables
            self.archiveExportOptions = archiveExportOptions
            self.provisioning = provisioning
            self.sourceControlBlueprint = sourceControlBlueprint
            self.deviceSpecification = deviceSpecification
            self.triggers = triggers
        }
    }
}
