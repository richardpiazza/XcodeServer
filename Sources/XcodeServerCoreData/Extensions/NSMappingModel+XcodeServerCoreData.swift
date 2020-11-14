import Foundation
#if canImport(CoreData)
import CoreData

extension NSMappingModel {
    #if swift(>=5.3)
    /// Loads the `NSMappingModel` from the `Bundle.module` that can be used to map the source to the destination.
    ///
    /// Mapping models should be bundled with the filename in the form of "MappingModel_{version}_{version}". For
    /// instance: "MappingModel_1.0.0_1.1.0".
    static func make(from: Model, to: Model) -> NSMappingModel? {
        let resource = "MappingModel_\(from.rawValue)_\(to.rawValue)"
        let url: URL
        if let _url = Bundle.module.url(forResource: resource, withExtension: .cdm) {
            url = _url
        } else if let _url = Bundle.module.url(forResource: resource, withExtension: "\(String.cdm)\(String.precompiled)") {
            url = _url
        } else {
            return nil
        }
        
        guard let mapping = NSMappingModel(contentsOf: url) else {
            return nil
        }
        
        return mapping
    }
    #endif
}

#endif
