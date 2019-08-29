import Foundation
import CoreData

extension NSManagedObject {
    public static var entityName: String {
        var entityName = NSStringFromClass(self)
        if let lastPeriodRange = entityName.range(of: ".", options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
            let range = lastPeriodRange.upperBound..<entityName.endIndex
            entityName = String(entityName[range])
        }
        
        return entityName
    }
    
    public convenience init?(managedObjectContext context: NSManagedObjectContext) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: type(of: self).entityName, in: context) else {
            return nil
        }
        
        self.init(entity: entityDescription, insertInto: context)
    }
}
