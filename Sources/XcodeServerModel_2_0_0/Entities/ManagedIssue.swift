import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedIssue: NSManagedObject {

}

extension ManagedIssue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedIssue> {
        return NSFetchRequest<ManagedIssue>(entityName: "ManagedIssue")
    }

    @NSManaged public var age: Int32
    @NSManaged public var documentFilePath: String?
    @NSManaged public var documentLocationData: String?
    @NSManaged public var fixItType: String?
    @NSManaged public var identifier: String?
    @NSManaged public var issueType: String?
    @NSManaged public var lineNumber: Int32
    @NSManaged public var message: String?
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var target: String?
    @NSManaged public var testCase: String?
    @NSManaged public var typeRawValue: String?
    @NSManaged public var inverseBuildServiceErrors: NSSet?
    @NSManaged public var inverseBuildServiceWarnings: NSSet?
    @NSManaged public var inverseFreshAnalyzerWarnings: NSSet?
    @NSManaged public var inverseFreshErrors: NSSet?
    @NSManaged public var inverseFreshTestFailures: NSSet?
    @NSManaged public var inverseFreshWarnings: NSSet?
    @NSManaged public var inverseResolvedAnalyzerWarnings: NSSet?
    @NSManaged public var inverseResolvedErrors: NSSet?
    @NSManaged public var inverseResolvedTestFailures: NSSet?
    @NSManaged public var inverseResolvedWarnings: NSSet?
    @NSManaged public var inverseTriggerErrors: NSSet?
    @NSManaged public var inverseUnresolvedAnalyzerWarnings: NSSet?
    @NSManaged public var inverseUnresolvedErrors: NSSet?
    @NSManaged public var inverseUnresolvedTestFailures: NSSet?
    @NSManaged public var inverseUnresolvedWarnings: NSSet?

}

// MARK: Generated accessors for inverseBuildServiceErrors
extension ManagedIssue {

    @objc(addInverseBuildServiceErrorsObject:)
    @NSManaged public func addToInverseBuildServiceErrors(_ value: ManagedIntegrationIssues)

    @objc(removeInverseBuildServiceErrorsObject:)
    @NSManaged public func removeFromInverseBuildServiceErrors(_ value: ManagedIntegrationIssues)

    @objc(addInverseBuildServiceErrors:)
    @NSManaged public func addToInverseBuildServiceErrors(_ values: NSSet)

    @objc(removeInverseBuildServiceErrors:)
    @NSManaged public func removeFromInverseBuildServiceErrors(_ values: NSSet)

}

// MARK: Generated accessors for inverseBuildServiceWarnings
extension ManagedIssue {

    @objc(addInverseBuildServiceWarningsObject:)
    @NSManaged public func addToInverseBuildServiceWarnings(_ value: ManagedIntegrationIssues)

    @objc(removeInverseBuildServiceWarningsObject:)
    @NSManaged public func removeFromInverseBuildServiceWarnings(_ value: ManagedIntegrationIssues)

    @objc(addInverseBuildServiceWarnings:)
    @NSManaged public func addToInverseBuildServiceWarnings(_ values: NSSet)

    @objc(removeInverseBuildServiceWarnings:)
    @NSManaged public func removeFromInverseBuildServiceWarnings(_ values: NSSet)

}

// MARK: Generated accessors for inverseFreshAnalyzerWarnings
extension ManagedIssue {

    @objc(addInverseFreshAnalyzerWarningsObject:)
    @NSManaged public func addToInverseFreshAnalyzerWarnings(_ value: ManagedIntegrationIssues)

    @objc(removeInverseFreshAnalyzerWarningsObject:)
    @NSManaged public func removeFromInverseFreshAnalyzerWarnings(_ value: ManagedIntegrationIssues)

    @objc(addInverseFreshAnalyzerWarnings:)
    @NSManaged public func addToInverseFreshAnalyzerWarnings(_ values: NSSet)

    @objc(removeInverseFreshAnalyzerWarnings:)
    @NSManaged public func removeFromInverseFreshAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for inverseFreshErrors
extension ManagedIssue {

    @objc(addInverseFreshErrorsObject:)
    @NSManaged public func addToInverseFreshErrors(_ value: ManagedIntegrationIssues)

    @objc(removeInverseFreshErrorsObject:)
    @NSManaged public func removeFromInverseFreshErrors(_ value: ManagedIntegrationIssues)

    @objc(addInverseFreshErrors:)
    @NSManaged public func addToInverseFreshErrors(_ values: NSSet)

    @objc(removeInverseFreshErrors:)
    @NSManaged public func removeFromInverseFreshErrors(_ values: NSSet)

}

// MARK: Generated accessors for inverseFreshTestFailures
extension ManagedIssue {

    @objc(addInverseFreshTestFailuresObject:)
    @NSManaged public func addToInverseFreshTestFailures(_ value: ManagedIntegrationIssues)

    @objc(removeInverseFreshTestFailuresObject:)
    @NSManaged public func removeFromInverseFreshTestFailures(_ value: ManagedIntegrationIssues)

    @objc(addInverseFreshTestFailures:)
    @NSManaged public func addToInverseFreshTestFailures(_ values: NSSet)

    @objc(removeInverseFreshTestFailures:)
    @NSManaged public func removeFromInverseFreshTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for inverseFreshWarnings
extension ManagedIssue {

    @objc(addInverseFreshWarningsObject:)
    @NSManaged public func addToInverseFreshWarnings(_ value: ManagedIntegrationIssues)

    @objc(removeInverseFreshWarningsObject:)
    @NSManaged public func removeFromInverseFreshWarnings(_ value: ManagedIntegrationIssues)

    @objc(addInverseFreshWarnings:)
    @NSManaged public func addToInverseFreshWarnings(_ values: NSSet)

    @objc(removeInverseFreshWarnings:)
    @NSManaged public func removeFromInverseFreshWarnings(_ values: NSSet)

}

// MARK: Generated accessors for inverseResolvedAnalyzerWarnings
extension ManagedIssue {

    @objc(addInverseResolvedAnalyzerWarningsObject:)
    @NSManaged public func addToInverseResolvedAnalyzerWarnings(_ value: ManagedIntegrationIssues)

    @objc(removeInverseResolvedAnalyzerWarningsObject:)
    @NSManaged public func removeFromInverseResolvedAnalyzerWarnings(_ value: ManagedIntegrationIssues)

    @objc(addInverseResolvedAnalyzerWarnings:)
    @NSManaged public func addToInverseResolvedAnalyzerWarnings(_ values: NSSet)

    @objc(removeInverseResolvedAnalyzerWarnings:)
    @NSManaged public func removeFromInverseResolvedAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for inverseResolvedErrors
extension ManagedIssue {

    @objc(addInverseResolvedErrorsObject:)
    @NSManaged public func addToInverseResolvedErrors(_ value: ManagedIntegrationIssues)

    @objc(removeInverseResolvedErrorsObject:)
    @NSManaged public func removeFromInverseResolvedErrors(_ value: ManagedIntegrationIssues)

    @objc(addInverseResolvedErrors:)
    @NSManaged public func addToInverseResolvedErrors(_ values: NSSet)

    @objc(removeInverseResolvedErrors:)
    @NSManaged public func removeFromInverseResolvedErrors(_ values: NSSet)

}

// MARK: Generated accessors for inverseResolvedTestFailures
extension ManagedIssue {

    @objc(addInverseResolvedTestFailuresObject:)
    @NSManaged public func addToInverseResolvedTestFailures(_ value: ManagedIntegrationIssues)

    @objc(removeInverseResolvedTestFailuresObject:)
    @NSManaged public func removeFromInverseResolvedTestFailures(_ value: ManagedIntegrationIssues)

    @objc(addInverseResolvedTestFailures:)
    @NSManaged public func addToInverseResolvedTestFailures(_ values: NSSet)

    @objc(removeInverseResolvedTestFailures:)
    @NSManaged public func removeFromInverseResolvedTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for inverseResolvedWarnings
extension ManagedIssue {

    @objc(addInverseResolvedWarningsObject:)
    @NSManaged public func addToInverseResolvedWarnings(_ value: ManagedIntegrationIssues)

    @objc(removeInverseResolvedWarningsObject:)
    @NSManaged public func removeFromInverseResolvedWarnings(_ value: ManagedIntegrationIssues)

    @objc(addInverseResolvedWarnings:)
    @NSManaged public func addToInverseResolvedWarnings(_ values: NSSet)

    @objc(removeInverseResolvedWarnings:)
    @NSManaged public func removeFromInverseResolvedWarnings(_ values: NSSet)

}

// MARK: Generated accessors for inverseTriggerErrors
extension ManagedIssue {

    @objc(addInverseTriggerErrorsObject:)
    @NSManaged public func addToInverseTriggerErrors(_ value: ManagedIntegrationIssues)

    @objc(removeInverseTriggerErrorsObject:)
    @NSManaged public func removeFromInverseTriggerErrors(_ value: ManagedIntegrationIssues)

    @objc(addInverseTriggerErrors:)
    @NSManaged public func addToInverseTriggerErrors(_ values: NSSet)

    @objc(removeInverseTriggerErrors:)
    @NSManaged public func removeFromInverseTriggerErrors(_ values: NSSet)

}

// MARK: Generated accessors for inverseUnresolvedAnalyzerWarnings
extension ManagedIssue {

    @objc(addInverseUnresolvedAnalyzerWarningsObject:)
    @NSManaged public func addToInverseUnresolvedAnalyzerWarnings(_ value: ManagedIntegrationIssues)

    @objc(removeInverseUnresolvedAnalyzerWarningsObject:)
    @NSManaged public func removeFromInverseUnresolvedAnalyzerWarnings(_ value: ManagedIntegrationIssues)

    @objc(addInverseUnresolvedAnalyzerWarnings:)
    @NSManaged public func addToInverseUnresolvedAnalyzerWarnings(_ values: NSSet)

    @objc(removeInverseUnresolvedAnalyzerWarnings:)
    @NSManaged public func removeFromInverseUnresolvedAnalyzerWarnings(_ values: NSSet)

}

// MARK: Generated accessors for inverseUnresolvedErrors
extension ManagedIssue {

    @objc(addInverseUnresolvedErrorsObject:)
    @NSManaged public func addToInverseUnresolvedErrors(_ value: ManagedIntegrationIssues)

    @objc(removeInverseUnresolvedErrorsObject:)
    @NSManaged public func removeFromInverseUnresolvedErrors(_ value: ManagedIntegrationIssues)

    @objc(addInverseUnresolvedErrors:)
    @NSManaged public func addToInverseUnresolvedErrors(_ values: NSSet)

    @objc(removeInverseUnresolvedErrors:)
    @NSManaged public func removeFromInverseUnresolvedErrors(_ values: NSSet)

}

// MARK: Generated accessors for inverseUnresolvedTestFailures
extension ManagedIssue {

    @objc(addInverseUnresolvedTestFailuresObject:)
    @NSManaged public func addToInverseUnresolvedTestFailures(_ value: ManagedIntegrationIssues)

    @objc(removeInverseUnresolvedTestFailuresObject:)
    @NSManaged public func removeFromInverseUnresolvedTestFailures(_ value: ManagedIntegrationIssues)

    @objc(addInverseUnresolvedTestFailures:)
    @NSManaged public func addToInverseUnresolvedTestFailures(_ values: NSSet)

    @objc(removeInverseUnresolvedTestFailures:)
    @NSManaged public func removeFromInverseUnresolvedTestFailures(_ values: NSSet)

}

// MARK: Generated accessors for inverseUnresolvedWarnings
extension ManagedIssue {

    @objc(addInverseUnresolvedWarningsObject:)
    @NSManaged public func addToInverseUnresolvedWarnings(_ value: ManagedIntegrationIssues)

    @objc(removeInverseUnresolvedWarningsObject:)
    @NSManaged public func removeFromInverseUnresolvedWarnings(_ value: ManagedIntegrationIssues)

    @objc(addInverseUnresolvedWarnings:)
    @NSManaged public func addToInverseUnresolvedWarnings(_ values: NSSet)

    @objc(removeInverseUnresolvedWarnings:)
    @NSManaged public func removeFromInverseUnresolvedWarnings(_ values: NSSet)

}

extension ManagedIssue {
    static func issue(_ id: Issue.ID, in context: NSManagedObjectContext) -> ManagedIssue? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedIssue.identifier), id)
        do {
            return try context.fetch(request).first
        } catch {
            PersistentContainer.logger.error("Failed to fetch `ManagedIssue`.", metadata: [
                "Issue.ID": .string(id),
                "localizedDescription": .string(error.localizedDescription)
            ])
        }
        
        return nil
    }
    
    var status: Issue.Status {
        get { Issue.Status(rawValue: Int(statusRawValue)) ?? .new }
        set { statusRawValue = Int16(newValue.rawValue) }
    }
    
    var type: Issue.Category {
        get { Issue.Category(rawValue: typeRawValue ?? "") ?? .unknown }
        set { typeRawValue = newValue.rawValue }
    }
    
    func update(_ issue: Issue, context: NSManagedObjectContext) {
        identifier = issue.id
        age = Int32(issue.age)
        documentFilePath = issue.documentFilePath
        documentLocationData = issue.documentLocationData
        fixItType = issue.fixItType
        lineNumber = Int32(issue.lineNumber)
        message = issue.message
        status = issue.status
        target = issue.target
        testCase = issue.testCase
        type = issue.type
    }
}

extension Issue {
    init(_ issue: ManagedIssue) {
        self.init(id: issue.identifier ?? "")
        age = Int(issue.age)
        documentFilePath = issue.documentFilePath ?? ""
        fixItType = issue.fixItType ?? ""
        status = issue.status
        type = issue.type
        lineNumber = Int(issue.lineNumber)
        message = issue.message ?? ""
        testCase = issue.testCase ?? ""
    }
}
#endif
