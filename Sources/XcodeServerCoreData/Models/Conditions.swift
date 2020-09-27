import Foundation
#if canImport(CoreData)
import CoreData

@objc(Conditions)
public class Conditions: NSManagedObject {
    
    @NSManaged public var onAllIssuesResolved: Bool
    @NSManaged public var onAnalyzerWarnings: Bool
    @NSManaged public var onBuildErrors: Bool
    @NSManaged public var onFailingTests: Bool
    @NSManaged public var onInternalErrors: Bool
    @NSManaged public var onSuccess: Bool
    @NSManaged public var onWarnings: Bool
    @NSManaged public var statusRawValue: Int16
    @NSManaged public var trigger: Trigger?
    
}

#endif
