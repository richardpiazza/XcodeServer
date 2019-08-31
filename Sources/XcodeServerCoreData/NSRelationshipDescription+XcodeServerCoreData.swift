import Foundation
import CoreData

public extension NSRelationshipDescription {
    convenience init(name: String, minCount: Int = 0, maxCount: Int, deleteRule: NSDeleteRule, isOptional: Bool = true) {
        self.init()
        self.name = name
        self.minCount = minCount
        self.maxCount = maxCount
        self.deleteRule = deleteRule
        self.isOptional = isOptional
    }
}
