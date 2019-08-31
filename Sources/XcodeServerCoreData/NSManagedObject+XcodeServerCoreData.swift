import Foundation
import CoreData

public extension NSManagedObject {
    static var entityName: String {
        var entityName = NSStringFromClass(self)
        if let lastPeriodRange = entityName.range(of: ".", options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
            let range = lastPeriodRange.upperBound..<entityName.endIndex
            entityName = String(entityName[range])
        }
        
        return entityName
    }
    
    convenience init?(managedObjectContext context: NSManagedObjectContext) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: type(of: self).entityName, in: context) else {
            return nil
        }
        
        self.init(entity: entityDescription, insertInto: context)
    }
}
