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
    func make<T>() -> T where T: NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: self) as! T
    }
}
#endif
