import Foundation
#if canImport(CoreData)
import CoreData

@objc(IntegrationIssues)
public class IntegrationIssues: NSManagedObject {

}

extension IntegrationIssues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IntegrationIssues> {
        return NSFetchRequest<IntegrationIssues>(entityName: "IntegrationIssues")
    }

    @NSManaged public var buildServiceErrors: NSSet?
    @NSManaged public var buildServiceWarnings: NSSet?
    @NSManaged public var freshAnalyzerWarnings: NSSet?
    @NSManaged public var freshErrors: NSSet?
    @NSManaged public var freshTestFailures: NSSet?
    @NSManaged public var freshWarnings: NSSet?
    @NSManaged public var integration: Integration?
    @NSManaged public var resolvedAnalyzerWarnings: NSSet?
    @NSManaged public var resolvedErrors: NSSet?
    @NSManaged public var resolvedTestFailures: NSSet?
    @NSManaged public var resolvedWarnings: NSSet?
    @NSManaged public var unresolvedAnalyzerWarnings: NSSet?
    @NSManaged public var unresolvedErrors: NSSet?
    @NSManaged public var unresolvedTestFailures: NSSet?
    @NSManaged public var unresolvedWarnings: NSSet?
    @NSManaged public var triggerErrors: NSSet?

}

// MARK: Generated accessors for buildServiceErrors
extension IntegrationIssues {

    @objc(addBuildServiceErrorsObject:)
    @NSManaged public func addToBuildServiceErrors(_ value: Issue)

    @objc(removeBuildServiceErrorsObject:)
    @NSManaged public func removeFromBuildServiceErrors(_ value: Issue)

    @objc(addBuildServiceErrors:)
    @NSManaged public func addToBuildServiceErrors(_ values: NSSet)

    @objc(removeBuildServiceErrors:)
    @NSManaged public func removeFromBuildServiceErrors(_ values: NSSet)

}

// MARK: Generated accessors for buildServiceWarnings
extension IntegrationIssues {

    @objc(addBuildServiceWarningsObject:)
    @NSManaged public func addToBuildServiceWarnings(_ value: Issue)

    @objc(removeBuildServiceWarningsObject:)
    @NSManaged public func removeFromBuildServiceWarnings(_ value: Issue)

    @objc(addBuildServiceWarnings:)
    @NSManaged public func addToBuildServiceWarnings(_ values: NSSet)

    @objc(removeBuildServiceWarnings:)
    @NSManaged public func removeFromBuildServiceWarnings(_ values: NSSet)

}

// MARK: Generated accessors for freshAnalyzerWarnings
extension IntegrationIssues {

    @objc(addFreshAnalyzerWarningsObject:)
    @NSManaged public func addToFreshAnalyzerWarnings(_ value: Issue)

    @objc(removeFreshAnalyzerWarningsObject:)
    @NSManaged public func removeFromFreshAnalyzerWarnings(_ value: Issue)

    @objc(addFreshAnalyzerWarnings:)
    @NSManaged public func addToFreshAnalyzerWarnings(_ values: NSSet)

    @objc(removeFreshAnalyzerWarnings:)
    @NSManaged public func removeFromFreshAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for freshErrors
extension IntegrationIssues {

    @objc(addFreshErrorsObject:)
    @NSManaged public func addToFreshErrors(_ value: Issue)

    @objc(removeFreshErrorsObject:)
    @NSManaged public func removeFromFreshErrors(_ value: Issue)

    @objc(addFreshErrors:)
    @NSManaged public func addToFreshErrors(_ values: NSSet)

    @objc(removeFreshErrors:)
    @NSManaged public func removeFromFreshErrors(_ values: NSSet)

}

// MARK: Generated accessors for freshTestFailures
extension IntegrationIssues {

    @objc(addFreshTestFailuresObject:)
    @NSManaged public func addToFreshTestFailures(_ value: Issue)

    @objc(removeFreshTestFailuresObject:)
    @NSManaged public func removeFromFreshTestFailures(_ value: Issue)

    @objc(addFreshTestFailures:)
    @NSManaged public func addToFreshTestFailures(_ values: NSSet)

    @objc(removeFreshTestFailures:)
    @NSManaged public func removeFromFreshTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for freshWarnings
extension IntegrationIssues {

    @objc(addFreshWarningsObject:)
    @NSManaged public func addToFreshWarnings(_ value: Issue)

    @objc(removeFreshWarningsObject:)
    @NSManaged public func removeFromFreshWarnings(_ value: Issue)

    @objc(addFreshWarnings:)
    @NSManaged public func addToFreshWarnings(_ values: NSSet)

    @objc(removeFreshWarnings:)
    @NSManaged public func removeFromFreshWarnings(_ values: NSSet)

}

// MARK: Generated accessors for resolvedAnalyzerWarnings
extension IntegrationIssues {

    @objc(addResolvedAnalyzerWarningsObject:)
    @NSManaged public func addToResolvedAnalyzerWarnings(_ value: Issue)

    @objc(removeResolvedAnalyzerWarningsObject:)
    @NSManaged public func removeFromResolvedAnalyzerWarnings(_ value: Issue)

    @objc(addResolvedAnalyzerWarnings:)
    @NSManaged public func addToResolvedAnalyzerWarnings(_ values: NSSet)

    @objc(removeResolvedAnalyzerWarnings:)
    @NSManaged public func removeFromResolvedAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for resolvedErrors
extension IntegrationIssues {

    @objc(addResolvedErrorsObject:)
    @NSManaged public func addToResolvedErrors(_ value: Issue)

    @objc(removeResolvedErrorsObject:)
    @NSManaged public func removeFromResolvedErrors(_ value: Issue)

    @objc(addResolvedErrors:)
    @NSManaged public func addToResolvedErrors(_ values: NSSet)

    @objc(removeResolvedErrors:)
    @NSManaged public func removeFromResolvedErrors(_ values: NSSet)

}

// MARK: Generated accessors for resolvedTestFailures
extension IntegrationIssues {

    @objc(addResolvedTestFailuresObject:)
    @NSManaged public func addToResolvedTestFailures(_ value: Issue)

    @objc(removeResolvedTestFailuresObject:)
    @NSManaged public func removeFromResolvedTestFailures(_ value: Issue)

    @objc(addResolvedTestFailures:)
    @NSManaged public func addToResolvedTestFailures(_ values: NSSet)

    @objc(removeResolvedTestFailures:)
    @NSManaged public func removeFromResolvedTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for resolvedWarnings
extension IntegrationIssues {

    @objc(addResolvedWarningsObject:)
    @NSManaged public func addToResolvedWarnings(_ value: Issue)

    @objc(removeResolvedWarningsObject:)
    @NSManaged public func removeFromResolvedWarnings(_ value: Issue)

    @objc(addResolvedWarnings:)
    @NSManaged public func addToResolvedWarnings(_ values: NSSet)

    @objc(removeResolvedWarnings:)
    @NSManaged public func removeFromResolvedWarnings(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedAnalyzerWarnings
extension IntegrationIssues {

    @objc(addUnresolvedAnalyzerWarningsObject:)
    @NSManaged public func addToUnresolvedAnalyzerWarnings(_ value: Issue)

    @objc(removeUnresolvedAnalyzerWarningsObject:)
    @NSManaged public func removeFromUnresolvedAnalyzerWarnings(_ value: Issue)

    @objc(addUnresolvedAnalyzerWarnings:)
    @NSManaged public func addToUnresolvedAnalyzerWarnings(_ values: NSSet)

    @objc(removeUnresolvedAnalyzerWarnings:)
    @NSManaged public func removeFromUnresolvedAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedErrors
extension IntegrationIssues {

    @objc(addUnresolvedErrorsObject:)
    @NSManaged public func addToUnresolvedErrors(_ value: Issue)

    @objc(removeUnresolvedErrorsObject:)
    @NSManaged public func removeFromUnresolvedErrors(_ value: Issue)

    @objc(addUnresolvedErrors:)
    @NSManaged public func addToUnresolvedErrors(_ values: NSSet)

    @objc(removeUnresolvedErrors:)
    @NSManaged public func removeFromUnresolvedErrors(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedTestFailures
extension IntegrationIssues {

    @objc(addUnresolvedTestFailuresObject:)
    @NSManaged public func addToUnresolvedTestFailures(_ value: Issue)

    @objc(removeUnresolvedTestFailuresObject:)
    @NSManaged public func removeFromUnresolvedTestFailures(_ value: Issue)

    @objc(addUnresolvedTestFailures:)
    @NSManaged public func addToUnresolvedTestFailures(_ values: NSSet)

    @objc(removeUnresolvedTestFailures:)
    @NSManaged public func removeFromUnresolvedTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for unresolvedWarnings
extension IntegrationIssues {

    @objc(addUnresolvedWarningsObject:)
    @NSManaged public func addToUnresolvedWarnings(_ value: Issue)

    @objc(removeUnresolvedWarningsObject:)
    @NSManaged public func removeFromUnresolvedWarnings(_ value: Issue)

    @objc(addUnresolvedWarnings:)
    @NSManaged public func addToUnresolvedWarnings(_ values: NSSet)

    @objc(removeUnresolvedWarnings:)
    @NSManaged public func removeFromUnresolvedWarnings(_ values: NSSet)

}

// MARK: Generated accessors for triggerErrors
extension IntegrationIssues {

    @objc(addTriggerErrorsObject:)
    @NSManaged public func addToTriggerErrors(_ value: Issue)

    @objc(removeTriggerErrorsObject:)
    @NSManaged public func removeFromTriggerErrors(_ value: Issue)

    @objc(addTriggerErrors:)
    @NSManaged public func addToTriggerErrors(_ values: NSSet)

    @objc(removeTriggerErrors:)
    @NSManaged public func removeFromTriggerErrors(_ values: NSSet)

}
#endif
