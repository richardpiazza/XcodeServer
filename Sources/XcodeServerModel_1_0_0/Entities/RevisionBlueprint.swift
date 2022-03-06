import XcodeServer
import CoreDataPlus
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
            PersistentContainer.logger.error("Failed to fetch revision blueprints", metadata: ["localizedDescription": .string(error.localizedDescription)])
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
            PersistentContainer.logger.error("Failed to fetch revision blueprint", metadata: ["localizedDescription": .string(error.localizedDescription)])
        }
        
        return nil
    }
}
#endif
