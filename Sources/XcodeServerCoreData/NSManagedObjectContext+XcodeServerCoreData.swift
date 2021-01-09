import Foundation
import XcodeServer
#if canImport(CoreData)
import CoreData

public extension NSManagedObjectContext {
    /// Inserts a new entity for the specified type.
    ///
    /// When initializing multiple models with duplicate entities, the standard `NSManagedObject.init(context:)` will
    /// have difficulties disambiguating the references. Using `NSEntityDescription.insertNewObject(forEntityName:into:)`
    /// seems to not have the problem.
    @available(*, deprecated, renamed: "make(modulePrefix:)")
    func make<T>() -> T where T: NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: self) as! T
    }
    
    func make<T>(modulePrefix prefix: String) -> T where T: NSManagedObject {
        let entityName = [prefix, T.entityName].joined(separator: ".")
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self) else {
            preconditionFailure()
        }
        
        return T(entity: entity, insertInto: self)
    }
}
#endif
