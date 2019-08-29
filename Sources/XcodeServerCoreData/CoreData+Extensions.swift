import Foundation
import CoreData

public extension NSEntityDescription {
    convenience init(name: String) {
        self.init()
        self.name = name
        self.managedObjectClassName = name
    }
}

public extension NSAttributeDescription {
    convenience init(name: String, type: NSAttributeType, isOptional: Bool = true, defaultValue: Any? = nil) {
        self.init()
        self.name = name
        self.attributeType = type
        self.isOptional = isOptional
        self.defaultValue = defaultValue
    }
}

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

public extension NSEntityMapping {
    convenience init(entityName: String, sourceModel: NSManagedObjectModel, destinationModel: NSManagedObjectModel) {
        self.init()
        name = String(format: "%@To%@", entityName, entityName)
        mappingType = .transformEntityMappingType
        sourceEntityName = entityName
        sourceEntityVersionHash = sourceModel.entityVersionHashesByName[entityName]
        destinationEntityName = entityName
        destinationEntityVersionHash = destinationModel.entityVersionHashesByName[entityName]
        attributeMappings = []
        relationshipMappings = []
    }
}

public extension NSPropertyMapping {
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

