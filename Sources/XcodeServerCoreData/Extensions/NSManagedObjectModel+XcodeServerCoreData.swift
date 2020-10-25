import Foundation
#if canImport(CoreData)
import CoreData

public extension NSManagedObjectModel {
    #if swift(>=5.3)
    /// The **XcodeServer.xcdatamodeld** referenced in the module resources.
    static var xcodeServer: NSManagedObjectModel = {
        guard let url = Bundle.module.url(forResource: "XcodeServer", withExtension: "momd") else {
            preconditionFailure("Unable to locate 'XcodeServer.momd' in `Bundle.module`.")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            preconditionFailure("Unable to construct `NSManagedObjectModel` from url '\(url)'.")
        }
        
        return model
    }()
    #endif
    
    /// Creates (if needed) and returns a `NSManagedObjectModel` for a defined `Model`.
    ///
    /// - note: Use static references or cache instances. Loading a model more than once into memory will cause
    ///         multiple references to be created.
    static func make(for model: Model) -> NSManagedObjectModel {
        switch model {
        case .v1_0_0: return Model_1_0_0.instance
        }
    }
}

#endif
