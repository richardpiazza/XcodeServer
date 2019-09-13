import Foundation
import XcodeServerCommon

public typealias TestResult = (name: String, passed: Bool)

#if canImport(CoreData)
import CoreData

/// ## Integration
/// An Xcode Server Bot integration (run).
/// "An integration is a single run of a bot. Integrations consist of building, analyzing, testing, and archiving the apps (or other software products) defined in your Xcode projects."
@objc(Integration)
public class Integration: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, identifier: String, bot: Bot? = nil) {
        self.init(managedObjectContext: managedObjectContext)
        self.identifier = identifier
        self.bot = bot
        self.buildResultSummary = BuildResultSummary(managedObjectContext: managedObjectContext, integration: self)
        self.assets = IntegrationAssets(managedObjectContext: managedObjectContext)
        self.issues = IntegrationIssues(managedObjectContext: managedObjectContext)
        self.duration = 0.0
        self.hasRetrievedAssets = false
        self.hasRetrievedCommits = false
        self.hasRetrievedIssues = false
        self.number = 0
        self.shouldClean = false
        self.successStreak = 0
    }

}

// MARK: - CoreData Properties
public extension Integration {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Integration> {
        return NSFetchRequest<Integration>(entityName: entityName)
    }
    
    @NSManaged var assets: IntegrationAssets?
    @NSManaged var bot: Bot?
    @NSManaged var buildResultSummary: BuildResultSummary?
    @NSManaged var currentStepRawValue: String?
    @NSManaged var duration: Double
    @NSManaged var endedTime: Date?
    @NSManaged var hasRetrievedAssets: Bool
    @NSManaged var hasRetrievedCommits: Bool
    @NSManaged var hasRetrievedIssues: Bool
    @NSManaged var identifier: String
    @NSManaged var lastUpdate: Date?
    @NSManaged var number: Int32
    @NSManaged var queuedDate: Date?
    @NSManaged var resultRawValue: String?
    @NSManaged var revision: String?
    @NSManaged var shouldClean: Bool
    @NSManaged var startedTime: Date?
    @NSManaged var successStreak: Int32
    @NSManaged var testHierachyData: Data?
    
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
        return Int(number)
    }
    
    var currentStep: IntegrationStep {
        get {
            return IntegrationStep(rawValue: currentStepRawValue ?? "") ?? .unknown
        }
        set {
            currentStepRawValue = newValue.rawValue
        }
    }
    
    var result: IntegrationResult {
        get {
            return IntegrationResult(rawValue: resultRawValue ?? "") ?? .unknown
        }
        set {
            resultRawValue = newValue.rawValue
        }
    }
}

public extension NSManagedObjectContext {
    /// Retrieves all `Integration` entities from the Core Data `NSManagedObjectContext`
    func integrations() -> [Integration] {
        let fetchRequest = NSFetchRequest<Integration>(entityName: Integration.entityName)
        do {
            return try self.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Retrieves the first `Integration` entity from the Core Data `NSManagedObjectContext`
    /// that matches the specified identifier.
    func integration(withIdentifier identifier: String) -> Integration? {
        let fetchRequest = NSFetchRequest<Integration>(entityName: Integration.entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", argumentArray: [identifier])
        do {
            let results = try self.fetch(fetchRequest)
            if let result = results.first {
                return result
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

#endif
