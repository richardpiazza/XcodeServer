import Foundation
#if canImport(CoreData)
import CoreData

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

#endif
