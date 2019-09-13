import Foundation
#if canImport(CoreData)
import CoreData

public extension NSAttributeDescription {
    convenience init(name: String, type: NSAttributeType, isOptional: Bool = true, defaultValue: Any? = nil) {
        self.init()
        self.name = name
        self.attributeType = type
        self.isOptional = isOptional
        self.defaultValue = defaultValue
    }
}

#endif
