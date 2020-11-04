import Foundation
#if canImport(CoreData)
import CoreData

public extension NSMappingModel {
    #if swift(>=5.3)
    /// Loads the `NSMappingModel` from the `Bundle.module` that can be used to map the source to the destination.
    ///
    /// Mapping models should be bundled with the filename in the form of "MappingModel_{version}_{version}". For
    /// instance: "MappingModel_1.0.0_1.1.0".
    static func make(from: Model, to: Model) throws -> NSMappingModel {
        let resource = "MappingModel_\(from.rawValue)_\(to.rawValue)"
        guard let url = Bundle.module.url(forResource: resource, withExtension: .cdm) else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        guard let mapping = NSMappingModel(contentsOf: url) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        return mapping
    }
    #endif
}

#endif
