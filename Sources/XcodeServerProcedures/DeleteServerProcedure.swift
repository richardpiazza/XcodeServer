import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class DeleteServerProcedure: NSManagedObjectProcedure<Server> {
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        let id = objectID
        
        print("Deleting Server '\(managedObject.fqdn)'")
        
        container.performBackgroundTask({ [weak self] (context) in
            let server = context.object(with: id) as! Server
            
            context.delete(server)
            
            do {
                try context.save()
                self?.finish()
            } catch {
                self?.finish(with: error)
            }
        })
    }
    
}

#endif
