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
    
    public var integrationNumber: Int {
        guard let value = self.number else {
            return 0
        }
        
        return value.intValue
    }
    
    public var integrationStep: IntegrationStep {
        guard let rawValue = self.currentStep else {
            return .unknown
        }
        
        guard let enumeration = IntegrationStep(rawValue: rawValue) else {
            return .unknown
        }
        
        return enumeration
    }
    
    public var integrationResult: IntegrationResult {
        guard let rawValue = self.result else {
            return .unknown
        }
        
        guard let enumeration = IntegrationResult(rawValue: rawValue) else {
            return .unknown
        }
        
        return enumeration
    }
}
