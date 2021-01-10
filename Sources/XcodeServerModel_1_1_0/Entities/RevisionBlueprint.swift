import XcodeServer
import XcodeServerCoreData
import Foundation
#if canImport(CoreData)
import CoreData

//@objc(RevisionBlueprint)
class RevisionBlueprint: NSManagedObject {

}

extension RevisionBlueprint {

    @nonobjc class func fetchRequest() -> NSFetchRequest<RevisionBlueprint> {
        return NSFetchRequest<RevisionBlueprint>(entityName: "RevisionBlueprint")
    }

    @NSManaged var commit: Commit?
    @NSManaged var integration: Integration?

}

extension RevisionBlueprint {
    /// Retrieves all `RevisionBlueprint` entities from the Core Data `NSManagedObjectContext`
    static func revisionBlueprints(in context: NSManagedObjectContext) -> [RevisionBlueprint] {
        let request = NSFetchRequest<RevisionBlueprint>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            InternalLog.persistence.error("Failed to fetch revision blueprints", error: error)
        }
        
        return []
    }
    
    /// Retrieves the first `RevisionBlueprint` entity from the Core Data `NSManagedObjectContext` that has a specific
    /// `Commit` and `Integration` associated with it.
    static func revisionBlueprint(withCommit commit: Commit, andIntegration integration: Integration, in context: NSManagedObjectContext) -> RevisionBlueprint? {
        let request = NSFetchRequest<RevisionBlueprint>(entityName: entityName)
        request.predicate = NSPredicate(format: "commit = %@ AND integration = %@", argumentArray: [commit, integration])
        do {
            return try context.fetch(request).first
        } catch {
            InternalLog.persistence.error("Failed to fetch revision blueprint", error: error)
        }
        
        return nil
    }
}
#endif
