import Foundation
import CoreData
import ProcedureKit
import XcodeServerAPI
import XcodeServerCoreData

open class NSPersistentContainerProcedure: Procedure {
    
    open var object: NSManagedObject
    open var container: NSPersistentContainer = .xcodeServerCoreData
    
    public init(object: NSManagedObject) {
        self.object = object
        
        super.init()
    }
}
