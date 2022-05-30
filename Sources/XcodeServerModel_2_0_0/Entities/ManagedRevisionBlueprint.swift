import Foundation
import CoreDataPlus
import XcodeServer
#if canImport(CoreData)
import CoreData

public class ManagedRevisionBlueprint: NSManagedObject {

}

extension ManagedRevisionBlueprint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedRevisionBlueprint> {
        return NSFetchRequest<ManagedRevisionBlueprint>(entityName: "ManagedRevisionBlueprint")
    }

    @NSManaged public var commit: ManagedCommit?
    @NSManaged public var integration: ManagedIntegration?

}

extension ManagedRevisionBlueprint {
    static func fetchBlueprints(forIntegration id: Integration.ID) -> NSFetchRequest<ManagedRevisionBlueprint> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ManagedRevisionBlueprint.integration.identifier), id)
        return request
    }
    
    /// Retrieves all `ManagedRevisionBlueprint` entities from the Core Data `NSManagedObjectContext`
    static func revisionBlueprints(in context: NSManagedObjectContext) -> [ManagedRevisionBlueprint] {
        let request = NSFetchRequest<ManagedRevisionBlueprint>(entityName: entityName)
        do {
            return try context.fetch(request)
        } catch {
            PersistentContainer.logger.error("Failed to fetch revision blueprints", metadata: ["localizedDescription": .string(error.localizedDescription)])
        }
        
        return []
    }
    
    /// Retrieves the first `ManagedRevisionBlueprint` entity from the Core Data `NSManagedObjectContext` that has a specific `Commit` and `Integration`
    /// associated with it.
    static func revisionBlueprint(withCommit commit: ManagedCommit, andIntegration integration: ManagedIntegration, in context: NSManagedObjectContext) -> ManagedRevisionBlueprint? {
        let request = NSFetchRequest<ManagedRevisionBlueprint>(entityName: entityName)
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
