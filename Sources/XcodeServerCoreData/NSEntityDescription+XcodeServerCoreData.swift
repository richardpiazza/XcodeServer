import Foundation
import CoreData

public extension NSEntityDescription {
    convenience init(name: String) {
        self.init()
        self.name = name
        self.managedObjectClassName = name
    }
}
