import Foundation
#if canImport(CoreData)
import CoreData

extension NSPropertyMapping {
    convenience init(name: String, sourceName: String? = nil, entityMapping: String? = nil) {
        self.init()
        self.name = name
        
        let expression: NSExpression
        switch entityMapping {
        case .some(let mapping):
            expression = NSExpression(forFunction: NSExpression(forVariable: "manager"), selectorName: "destinationInstancesForEntityMappingNamed:sourceInstances:", arguments: [
                NSExpression(forConstantValue: String(format: "%@To%@", mapping, mapping)),
                NSExpression(forVariable: String(format: "source.%@", sourceName ?? name))
                ])
        case .none:
            expression = NSExpression(forVariable: String(format: "source.%@", sourceName ?? name))
        }
        
        self.valueExpression = expression
    }
}

#endif
