import Foundation
#if canImport(CoreData)
import CoreData

extension NSEntityDescription {
    convenience init(name: String) {
        self.init()
        self.name = name
        self.managedObjectClassName = name
    }
}

#endif
