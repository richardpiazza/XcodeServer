import Foundation

public extension Bot {
    
    struct Configuration: Hashable, Codable {
        
        public struct Provisioning: Hashable, Codable {
            public var addMissingDevicesToTeams: Bool = false
            public var manageCertsAndProfiles: Bool = false
            
            public init() {
            }
        }
        
        public struct ArchiveExport: Hashable, Codable {
            public var created: Date = Date()
            public var options: ExportOptions = ExportOptions()
            
            public init() {
            }
        }
        
        /// Parameters used during the export of a compiled/signed application.
        public struct ExportOptions: Hashable, Codable {
            public var method: String = ""
            public var teamID: String = ""
            public var uploadBitcode: Bool = false
            public var stripSwiftSymbols: Bool = false
            public var iCloudContainerEnvironment: String = ""
            public var signingCertificate: String = ""
            public var signingStyle: String = ""
            public var uploadSymbols: Bool = false
            public var provisioningProfiles: ProvisioningProfiles = [:]
            
            public init() {
            }
        }
        
        public typealias ProvisioningProfiles = [String: String]
        
        // MARK: - Schedule
        public var schedule: Schedule = .manual
        public var periodicInterval: PeriodicInterval = .none
        public var weeklyScheduleDay: Int = 0
        public var hourOfIntegration: Int = 0
        public var minutesAfterHourToIntegrate: Int = 0
        
        // MARK: - Options
        public var schemeName: String = ""
        public var cleaning: Cleaning = .never
        public var disableAppThinning: Bool = false
        public var coverage: Coverage = .useSchemeSetting
        public var useParallelDevices: Bool = false
        public var performsArchive: Bool = false
        public var performsAnalyze: Bool = false
        public var performsTest: Bool = false
        public var performsUpgradeIntegration: Bool = false
        public var exportsProduct: Bool = false
        public var runOnlyDisabledTests: Bool = false
        public var buildArguments: [String] = []
        public var environmentVariables: [String : String] = [:]
        public var archiveExportOptions: ArchiveExport = ArchiveExport()
        public var provisioning: Provisioning = Provisioning()
        public var sourceControlBlueprint: SourceControl.Blueprint = SourceControl.Blueprint()
        public var deviceSpecification: Device.Specification = Device.Specification()
        public var triggers: [Trigger] = []
        
        public init() {
        }
    }
}
