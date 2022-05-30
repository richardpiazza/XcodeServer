import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedIntegrationIssues: NSManagedObject {

}

extension ManagedIntegrationIssues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedIntegrationIssues> {
        return NSFetchRequest<ManagedIntegrationIssues>(entityName: "ManagedIntegrationIssues")
    }

    @NSManaged public var buildServiceErrors: NSSet?
    @NSManaged public var buildServiceWarnings: NSSet?
    @NSManaged public var freshAnalyzerWarnings: NSSet?
    @NSManaged public var freshErrors: NSSet?
    @NSManaged public var freshTestFailures: NSSet?
    @NSManaged public var freshWarnings: NSSet?
    @NSManaged public var integration: ManagedIntegration?
    @NSManaged public var resolvedAnalyzerWarnings: NSSet?
    @NSManaged public var resolvedErrors: NSSet?
    @NSManaged public var resolvedTestFailures: NSSet?
    @NSManaged public var resolvedWarnings: NSSet?
    @NSManaged public var triggerErrors: NSSet?
    @NSManaged public var unresolvedAnalyzerWarnings: NSSet?
    @NSManaged public var unresolvedErrors: NSSet?
    @NSManaged public var unresolvedTestFailures: NSSet?
    @NSManaged public var unresolvedWarnings: NSSet?

}

// MARK: Generated accessors for buildServiceErrors
extension ManagedIntegrationIssues {

    @objc(addBuildServiceErrorsObject:)
    @NSManaged public func addToBuildServiceErrors(_ value: ManagedIssue)

    @objc(removeBuildServiceErrorsObject:)
    @NSManaged public func removeFromBuildServiceErrors(_ value: ManagedIssue)

    @objc(addBuildServiceErrors:)
    @NSManaged public func addToBuildServiceErrors(_ values: NSSet)

    @objc(removeBuildServiceErrors:)
    @NSManaged public func removeFromBuildServiceErrors(_ values: NSSet)

}

// MARK: Generated accessors for buildServiceWarnings
extension ManagedIntegrationIssues {

    @objc(addBuildServiceWarningsObject:)
    @NSManaged public func addToBuildServiceWarnings(_ value: ManagedIssue)

    @objc(removeBuildServiceWarningsObject:)
    @NSManaged public func removeFromBuildServiceWarnings(_ value: ManagedIssue)

    @objc(addBuildServiceWarnings:)
    @NSManaged public func addToBuildServiceWarnings(_ values: NSSet)

    @objc(removeBuildServiceWarnings:)
    @NSManaged public func removeFromBuildServiceWarnings(_ values: NSSet)

}

// MARK: Generated accessors for freshAnalyzerWarnings
extension ManagedIntegrationIssues {

    @objc(addFreshAnalyzerWarningsObject:)
    @NSManaged public func addToFreshAnalyzerWarnings(_ value: ManagedIssue)

    @objc(removeFreshAnalyzerWarningsObject:)
    @NSManaged public func removeFromFreshAnalyzerWarnings(_ value: ManagedIssue)

    @objc(addFreshAnalyzerWarnings:)
    @NSManaged public func addToFreshAnalyzerWarnings(_ values: NSSet)

    @objc(removeFreshAnalyzerWarnings:)
    @NSManaged public func removeFromFreshAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for freshErrors
extension ManagedIntegrationIssues {

    @objc(addFreshErrorsObject:)
    @NSManaged public func addToFreshErrors(_ value: ManagedIssue)

    @objc(removeFreshErrorsObject:)
    @NSManaged public func removeFromFreshErrors(_ value: ManagedIssue)

    @objc(addFreshErrors:)
    @NSManaged public func addToFreshErrors(_ values: NSSet)

    @objc(removeFreshErrors:)
    @NSManaged public func removeFromFreshErrors(_ values: NSSet)

}

// MARK: Generated accessors for freshTestFailures
extension ManagedIntegrationIssues {

    @objc(addFreshTestFailuresObject:)
    @NSManaged public func addToFreshTestFailures(_ value: ManagedIssue)

    @objc(removeFreshTestFailuresObject:)
    @NSManaged public func removeFromFreshTestFailures(_ value: ManagedIssue)

    @objc(addFreshTestFailures:)
    @NSManaged public func addToFreshTestFailures(_ values: NSSet)

    @objc(removeFreshTestFailures:)
    @NSManaged public func removeFromFreshTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for freshWarnings
extension ManagedIntegrationIssues {

    @objc(addFreshWarningsObject:)
    @NSManaged public func addToFreshWarnings(_ value: ManagedIssue)

    @objc(removeFreshWarningsObject:)
    @NSManaged public func removeFromFreshWarnings(_ value: ManagedIssue)

    @objc(addFreshWarnings:)
    @NSManaged public func addToFreshWarnings(_ values: NSSet)

    @objc(removeFreshWarnings:)
    @NSManaged public func removeFromFreshWarnings(_ values: NSSet)

}

// MARK: Generated accessors for resolvedAnalyzerWarnings
extension ManagedIntegrationIssues {

    @objc(addResolvedAnalyzerWarningsObject:)
    @NSManaged public func addToResolvedAnalyzerWarnings(_ value: ManagedIssue)

    @objc(removeResolvedAnalyzerWarningsObject:)
    @NSManaged public func removeFromResolvedAnalyzerWarnings(_ value: ManagedIssue)

    @objc(addResolvedAnalyzerWarnings:)
    @NSManaged public func addToResolvedAnalyzerWarnings(_ values: NSSet)

    @objc(removeResolvedAnalyzerWarnings:)
    @NSManaged public func removeFromResolvedAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for resolvedErrors
extension ManagedIntegrationIssues {

    @objc(addResolvedErrorsObject:)
    @NSManaged public func addToResolvedErrors(_ value: ManagedIssue)

    @objc(removeResolvedErrorsObject:)
    @NSManaged public func removeFromResolvedErrors(_ value: ManagedIssue)

    @objc(addResolvedErrors:)
    @NSManaged public func addToResolvedErrors(_ values: NSSet)

    @objc(removeResolvedErrors:)
    @NSManaged public func removeFromResolvedErrors(_ values: NSSet)

}

// MARK: Generated accessors for resolvedTestFailures
extension ManagedIntegrationIssues {

    @objc(addResolvedTestFailuresObject:)
    @NSManaged public func addToResolvedTestFailures(_ value: ManagedIssue)

    @objc(removeResolvedTestFailuresObject:)
    @NSManaged public func removeFromResolvedTestFailures(_ value: ManagedIssue)

    @objc(addResolvedTestFailures:)
    @NSManaged public func addToResolvedTestFailures(_ values: NSSet)

    @objc(removeResolvedTestFailures:)
    @NSManaged public func removeFromResolvedTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for resolvedWarnings
extension ManagedIntegrationIssues {

    @objc(addResolvedWarningsObject:)
    @NSManaged public func addToResolvedWarnings(_ value: ManagedIssue)

    @objc(removeResolvedWarningsObject:)
    @NSManaged public func removeFromResolvedWarnings(_ value: ManagedIssue)

    @objc(addResolvedWarnings:)
    @NSManaged public func addToResolvedWarnings(_ values: NSSet)

    @objc(removeResolvedWarnings:)
    @NSManaged public func removeFromResolvedWarnings(_ values: NSSet)

}

// MARK: Generated accessors for triggerErrors
extension ManagedIntegrationIssues {

    @objc(addTriggerErrorsObject:)
    @NSManaged public func addToTriggerErrors(_ value: ManagedIssue)

    @objc(removeTriggerErrorsObject:)
    @NSManaged public func removeFromTriggerErrors(_ value: ManagedIssue)

    @objc(addTriggerErrors:)
    @NSManaged public func addToTriggerErrors(_ values: NSSet)

    @objc(removeTriggerErrors:)
    @NSManaged public func removeFromTriggerErrors(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedAnalyzerWarnings
extension ManagedIntegrationIssues {

    @objc(addUnresolvedAnalyzerWarningsObject:)
    @NSManaged public func addToUnresolvedAnalyzerWarnings(_ value: ManagedIssue)

    @objc(removeUnresolvedAnalyzerWarningsObject:)
    @NSManaged public func removeFromUnresolvedAnalyzerWarnings(_ value: ManagedIssue)

    @objc(addUnresolvedAnalyzerWarnings:)
    @NSManaged public func addToUnresolvedAnalyzerWarnings(_ values: NSSet)

    @objc(removeUnresolvedAnalyzerWarnings:)
    @NSManaged public func removeFromUnresolvedAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedErrors
extension ManagedIntegrationIssues {

    @objc(addUnresolvedErrorsObject:)
    @NSManaged public func addToUnresolvedErrors(_ value: ManagedIssue)

    @objc(removeUnresolvedErrorsObject:)
    @NSManaged public func removeFromUnresolvedErrors(_ value: ManagedIssue)

    @objc(addUnresolvedErrors:)
    @NSManaged public func addToUnresolvedErrors(_ values: NSSet)

    @objc(removeUnresolvedErrors:)
    @NSManaged public func removeFromUnresolvedErrors(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedTestFailures
extension ManagedIntegrationIssues {

    @objc(addUnresolvedTestFailuresObject:)
    @NSManaged public func addToUnresolvedTestFailures(_ value: ManagedIssue)

    @objc(removeUnresolvedTestFailuresObject:)
    @NSManaged public func removeFromUnresolvedTestFailures(_ value: ManagedIssue)

    @objc(addUnresolvedTestFailures:)
    @NSManaged public func addToUnresolvedTestFailures(_ values: NSSet)

    @objc(removeUnresolvedTestFailures:)
    @NSManaged public func removeFromUnresolvedTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedWarnings
extension ManagedIntegrationIssues {

    @objc(addUnresolvedWarningsObject:)
    @NSManaged public func addToUnresolvedWarnings(_ value: ManagedIssue)

    @objc(removeUnresolvedWarningsObject:)
    @NSManaged public func removeFromUnresolvedWarnings(_ value: ManagedIssue)

    @objc(addUnresolvedWarnings:)
    @NSManaged public func addToUnresolvedWarnings(_ values: NSSet)

    @objc(removeUnresolvedWarnings:)
    @NSManaged public func removeFromUnresolvedWarnings(_ values: NSSet)

}

extension ManagedIntegrationIssues {
    static func fetchIssues(forIntegration id: Integration.ID) -> NSFetchRequest<ManagedIntegrationIssues> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedIntegrationIssues.integration.identifier), id)
        return request
    }
}

extension ManagedIntegrationIssues {
    /// Update Integration Issues
    ///
    /// - note: Using the '_inverse_ = self' references here as an Issue may be linked to multiple Integrations.
    func update(_ catalog: Integration.IssueCatalog, context: NSManagedObjectContext) {
        catalog.buildServiceErrors.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToBuildServiceErrors(issue)
        })
        
        catalog.buildServiceWarnings.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToBuildServiceWarnings(issue)
        })
        
        catalog.errors.freshIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToFreshErrors(issue)
        })
        
        catalog.errors.resolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToResolvedErrors(issue)
        })
        
        catalog.errors.unresolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToUnresolvedErrors(issue)
        })
        
        catalog.warnings.freshIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToFreshWarnings(issue)
        })
        
        catalog.warnings.resolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToResolvedWarnings(issue)
        })
        
        catalog.warnings.unresolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToUnresolvedWarnings(issue)
        })
        
        catalog.analyzerWarnings.freshIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToFreshAnalyzerWarnings(issue)
        })
        
        catalog.analyzerWarnings.resolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToResolvedAnalyzerWarnings(issue)
        })
        
        catalog.analyzerWarnings.unresolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToUnresolvedAnalyzerWarnings(issue)
        })
        
        catalog.testFailures.freshIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToFreshTestFailures(issue)
        })
        
        catalog.testFailures.resolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToResolvedTestFailures(issue)
        })
        
        catalog.testFailures.unresolvedIssues.forEach({
            let issue: ManagedIssue
            if let existing = ManagedIssue.issue($0.id, in: context) {
                issue = existing
            } else {
                issue = context.make()
            }
            
            issue.update($0, context: context)
            addToUnresolvedTestFailures(issue)
        })
    }
}

extension Integration.IssueCatalog {
    init(_ issues: ManagedIntegrationIssues) {
        self.init()
        if let value = issues.buildServiceErrors as? Set<ManagedIssue> {
            buildServiceErrors = Set(value.map { Issue($0) })
        }
        if let value = issues.buildServiceWarnings as? Set<ManagedIssue> {
            buildServiceWarnings = Set(value.map { Issue($0) })
        }
        if let value = issues.freshErrors as? Set<ManagedIssue> {
            errors.freshIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.freshWarnings as? Set<ManagedIssue> {
            warnings.freshIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.freshTestFailures as? Set<ManagedIssue> {
            testFailures.freshIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.freshAnalyzerWarnings as? Set<ManagedIssue> {
            analyzerWarnings.freshIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.resolvedErrors as? Set<ManagedIssue> {
            errors.resolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.resolvedWarnings as? Set<ManagedIssue> {
            warnings.resolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.resolvedTestFailures as? Set<ManagedIssue> {
            testFailures.resolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.resolvedAnalyzerWarnings as? Set<ManagedIssue> {
            analyzerWarnings.resolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.unresolvedErrors as? Set<ManagedIssue> {
            errors.unresolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.unresolvedWarnings as? Set<ManagedIssue> {
            warnings.unresolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.unresolvedTestFailures as? Set<ManagedIssue> {
            testFailures.unresolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.unresolvedAnalyzerWarnings as? Set<ManagedIssue> {
            analyzerWarnings.unresolvedIssues = Set(value.map { Issue($0) })
        }
        if let value = issues.triggerErrors as? Set<ManagedIssue> {
            triggerErrors = Set(value.map { Issue($0) })
        }
    }
}
#endif
