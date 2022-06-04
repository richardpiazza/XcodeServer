import Foundation
import ArgumentParser
import XcodeServer
import XcodeServerCoreData
import CoreDataPlus

protocol Stored {
    /// Persisted store path
    var path: String? { get set }
    
    /// The model version to use when accessing the store
    var model: Model? { get set }
}

#if canImport(CoreData)
extension Stored {
    var storeURL: StoreURL {
        guard let path = self.path else {
            return StoreURL.xcodeServer
        }
        
        var filename = path
        if filename.hasSuffix(.sqlite) {
            filename = filename.replacingOccurrences(of: ".\(String.sqlite)", with: "")
        }
        
        return StoreURL(currentDirectory: filename)
    }
}
#endif
