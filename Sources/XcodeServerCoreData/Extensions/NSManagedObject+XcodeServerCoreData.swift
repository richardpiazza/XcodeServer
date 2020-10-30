import Foundation
#if canImport(CoreData)
import CoreData

extension NSManagedObject {
    static var entityName: String {
        var entityName = NSStringFromClass(self)
        if let lastPeriodRange = entityName.range(of: ".", options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
            let range = lastPeriodRange.upperBound..<entityName.endIndex
            entityName = String(entityName[range])
        }
        
        return entityName
    }
}

#endif
