import XcodeServer
import Logging
#if canImport(CoreData)
import CoreData
import CoreDataPlus

public class PersistentContainer: NSPersistentContainer {
    static let logger: Logger = Logger(label: "XcodeServer.CoreDataModel_1.0.0")
    
    public static var managedObjectModel: NSManagedObjectModel = {
        guard let model = try? Bundle.module.managedObjectModel(forResource: "XcodeServer") else {
            preconditionFailure("Failed to load model for resource 'XcodeServer.momd'.")
        }
        
        return model
    }()
}
#endif
