import Foundation
#if canImport(CoreData)
import CoreData

/// Models that have been loaded.
///
/// Loading a model more than once into memory will cause multiple `NSManagedObject` class references to be created.
fileprivate var models: [Model: NSManagedObjectModel] = [:]

public extension NSManagedObjectModel {
    /// Creates (if needed) and returns a `NSManagedObjectModel` for a defined `Model`.
    static func make(for model: Model) -> NSManagedObjectModel {
        if let existing = models[model] {
            return existing
        }
        
        let loaded: NSManagedObjectModel
        
        switch model {
        case .v1_0_0:
            loaded = Model_1_0_0()
        case .v1_1_0:
            loaded = Model_1_1_0()
        }
        
        models[model] = loaded
        return loaded
    }
}

internal extension NSManagedObjectModel {
    #if swift(>=5.3)
    /// The **XcodeServer.xcdatamodeld** referenced in the module resources.
    ///
    /// Ensure `Model.current` matches expected version.
    static var xcodeServer: NSManagedObjectModel? = {
        let url: URL
        if let _url = Bundle.module.url(forResource: .containerName, withExtension: .momd) {
            url = _url
        } else if let _url = Bundle.module.url(forResource: .containerName, withExtension: "\(String.momd)\(String.precompiled)") {
            url = _url
        } else {
            return nil
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            return nil
        }
        
        return model
    }()
    #endif
}

#endif
