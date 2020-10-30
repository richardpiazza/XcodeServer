import Foundation
#if canImport(CoreData)
import CoreData

@objc(IntegrationIssues)
public class IntegrationIssues: NSManagedObject {
    
    @NSManaged public var buildServiceErrors: Set<Issue>?
    @NSManaged public var buildServiceWarnings: Set<Issue>?
    @NSManaged public var freshAnalyzerWarnings: Set<Issue>?
    @NSManaged public var freshErrors: Set<Issue>?
    @NSManaged public var freshTestFailures: Set<Issue>?
    @NSManaged public var freshWarnings: Set<Issue>?
    @NSManaged public var integration: Integration?
    @NSManaged public var resolvedAnalyzerWarnings: Set<Issue>?
    @NSManaged public var resolvedErrors: Set<Issue>?
    @NSManaged public var resolvedTestFailures: Set<Issue>?
    @NSManaged public var resolvedWarnings: Set<Issue>?
    @NSManaged public var unresolvedAnalyzerWarnings: Set<Issue>?
    @NSManaged public var unresolvedErrors: Set<Issue>?
    @NSManaged public var unresolvedTestFailures: Set<Issue>?
    @NSManaged public var unresolvedWarnings: Set<Issue>?
    
}

#endif
