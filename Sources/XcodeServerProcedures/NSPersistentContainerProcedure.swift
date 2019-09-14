import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

open class NSPersistentContainerProcedure: Procedure {
    
    public let container: NSPersistentContainer
    
    public init(container: NSPersistentContainer) {
        self.container = container
        super.init()
    }
}

open class NSManagedObjectProcedure<T: NSManagedObject>: NSPersistentContainerProcedure {
    
    public let objectID: NSManagedObjectID
    public let managedObject: T
    
    public init(container: NSPersistentContainer, object: T) {
        self.objectID = object.objectID
        self.managedObject = object
        super.init(container: container)
    }
    
}

#endif
