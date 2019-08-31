import Foundation
import CoreData
import XcodeServerCommon

public typealias TestResult = (name: String, passed: Bool)

/// ## Integration
/// An Xcode Server Bot integration (run).
/// "An integration is a single run of a bot. Integrations consist of building, analyzing, testing, and archiving the apps (or other software products) defined in your Xcode projects."
public class Integration: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, bot: Bot? = nil) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.bot = bot
        self.buildResultSummary = BuildResultSummary(managedObjectContext: managedObjectContext, integration: self)
        self.assets = IntegrationAssets(managedObjectContext: managedObjectContext)
        self.issues = IntegrationIssues(managedObjectContext: managedObjectContext)
    }

}

// MARK: - CoreData Properties
public extension Integration {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Integration> {
        return NSFetchRequest<Integration>(entityName: entityName)
    }
    
    @NSManaged var currentStep: String?
    @NSManaged var duration: NSNumber?
    @NSManaged var endedTime: Date?
    @NSManaged var hasRetrievedAssets: NSNumber?
    @NSManaged var hasRetrievedCommits: NSNumber?
    @NSManaged var hasRetrievedIssues: NSNumber?
    @NSManaged var identifier: String
    @NSManaged var lastUpdate: Date?
    @NSManaged var number: NSNumber?
    @NSManaged var queuedDate: Date?
    @NSManaged var result: String?
    @NSManaged var shouldClean: NSNumber?
    @NSManaged var startedTime: Date?
    @NSManaged var successStreak: NSNumber?
    @NSManaged var testHierachy: NSObject?
    @NSManaged var testHierachyData: Data?
    @NSManaged var revision: String?
    @NSManaged var assets: IntegrationAssets?
    @NSManaged var bot: Bot?
    @NSManaged var buildResultSummary: BuildResultSummary?
    @NSManaged var inverseBestSuccessStreak: Stats?
    @NSManaged var inverseLastCleanIntegration: Stats?
    @NSManaged var issues: IntegrationIssues?
    @NSManaged var revisionBlueprints: Set<RevisionBlueprint>?
    @NSManaged var testedDevices: Set<Device>?
    
}

// MARK: Generated accessors for revisionBlueprints
extension Integration {
    
    @objc(addRevisionBlueprintsObject:)
    @NSManaged public func addToRevisionBlueprints(_ value: RevisionBlueprint)
    
    @objc(removeRevisionBlueprintsObject:)
    @NSManaged public func removeFromRevisionBlueprints(_ value: RevisionBlueprint)
    
    @objc(addRevisionBlueprints:)
    @NSManaged public func addToRevisionBlueprints(_ values: Set<RevisionBlueprint>)
    
    @objc(removeRevisionBlueprints:)
    @NSManaged public func removeFromRevisionBlueprints(_ values: Set<RevisionBlueprint>)
    
}

// MARK: Generated accessors for testedDevices
extension Integration {
    
    @objc(addTestedDevicesObject:)
    @NSManaged public func addToTestedDevices(_ value: Device)
    
    @objc(removeTestedDevicesObject:)
    @NSManaged public func removeFromTestedDevices(_ value: Device)
    
    @objc(addTestedDevices:)
    @NSManaged public func addToTestedDevices(_ values: Set<Device>)
    
    @objc(removeTestedDevices:)
    @NSManaged public func removeFromTestedDevices(_ values: Set<Device>)
    
}

public extension Integration {
    var integrationNumber: Int {
        guard let value = self.number else {
            return 0
        }
        
        return value.intValue
    }
    
    var integrationStep: IntegrationStep {
        guard let rawValue = self.currentStep else {
            return .unknown
        }
        
        guard let enumeration = IntegrationStep(rawValue: rawValue) else {
            return .unknown
        }
        
        return enumeration
    }
    
    var integrationResult: IntegrationResult {
        guard let rawValue = self.result else {
            return .unknown
        }
        
        guard let enumeration = IntegrationResult(rawValue: rawValue) else {
            return .unknown
        }
        
        return enumeration
    }
}
