import Foundation
#if canImport(CoreData)
import CoreData

@objc(RevisionBlueprint)
public class RevisionBlueprint: NSManagedObject {

}

extension RevisionBlueprint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RevisionBlueprint> {
        return NSFetchRequest<RevisionBlueprint>(entityName: "RevisionBlueprint")
    }

    @NSManaged public var commit: Commit?
    @NSManaged public var integration: Integration?

}
#endif
