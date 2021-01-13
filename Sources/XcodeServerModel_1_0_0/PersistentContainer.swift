import XcodeServer
import CoreDataPlus
import Dispatch
#if canImport(CoreData)
import CoreData

public class PersistentContainer: NSPersistentContainer {
    public let internalQueue: DispatchQueue = .init(label: "XcodeServerModel_1_0_0.PersistentContainer")
    public var dispatchQueue: DispatchQueue = .main
    
    public static var managedObjectModel: NSManagedObjectModel = {
        guard let model = try? Bundle.module.managedObjectModel(forResource: "XcodeServer") else {
            preconditionFailure("Failed to load model for resource 'XcodeServer.momd'.")
        }
        
        return model
    }()
}
#endif
