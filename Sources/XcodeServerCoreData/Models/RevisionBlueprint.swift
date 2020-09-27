import Foundation
#if canImport(CoreData)
import CoreData

@objc(RevisionBlueprint)
public class RevisionBlueprint: NSManagedObject {
    
    @NSManaged public var commit: Commit?
    @NSManaged public var integration: Integration?
    
}

#endif
