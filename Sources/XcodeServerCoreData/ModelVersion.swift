import Foundation
import CoreData

public enum ModelVersion {
    case v2_0_3
    case v2_0_4
    
    public var model: NSManagedObjectModel {
        switch self {
        case .v2_0_3: return Model_2_0_3.instance
        case .v2_0_4: return Model_2_0_4.instance
        }
    }
    
    /// The `NSMappingModel` that allows this model to map to the next highest version.
    public var mappingModel: NSMappingModel? {
        switch self {
        case .v2_0_3: return Mapping_2_0_3_to_2_0_4.instance
        default: return nil
        }
    }
}
