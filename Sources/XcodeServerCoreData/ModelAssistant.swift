import XcodeServer
#if canImport(CoreData)
import CoreData

public class ModelAssistant {
    public typealias ManagedObjectModelMaker = (_ model: Model) -> NSManagedObjectModel
    public typealias MappingModelMaker = (_ model: Model) -> NSMappingModel?
    
    public let managedObjectModelFor: ManagedObjectModelMaker
    public let mappingModelTo: MappingModelMaker
    
    public init(managedObjectModelMaker: @escaping ManagedObjectModelMaker, mappingModelMaker: @escaping MappingModelMaker) {
        self.managedObjectModelFor = managedObjectModelMaker
        self.mappingModelTo = mappingModelMaker
    }
    
    public func modelCompatibleWith(_ metadata: [String: Any]) -> Model? {
        for model in Model.allCases {
            let managedObjectModel: NSManagedObjectModel = managedObjectModelFor(model)
            if managedObjectModel.isConfiguration(withName: .configurationName, compatibleWithStoreMetadata: metadata) {
                return model
            }
        }
        
        return nil
    }
}
#endif
