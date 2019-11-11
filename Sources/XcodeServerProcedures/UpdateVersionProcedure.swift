import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateVersionProcedure: NSManagedObjectProcedure<Server>, InputProcedure {
    
    public typealias Input = (XCSVersion, Int?)
    
    public var input: Pending<Input> = .pending
    
    public init(container: NSPersistentContainer, server: Server, input: Input? = nil) {
        super.init(container: container, object: server)
        
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let value = input.value else {
            let error = XcodeServerProcedureError.invalidInput
            cancel(with: error)
            finish(with: error)
            return
        }
        
        let id = objectID
        
        print("Updating Versions for Server '\(managedObject.fqdn)'")
        
        container.performBackgroundTask { [weak self] (context) in
            let server = context.object(with: id) as! Server
            
            server.lastUpdate = Date()
            server.update(withVersion: value.0, api: value.1)
            
            do {
                try context.save()
                self?.finish()
            } catch {
                self?.finish(with: error)
            }
        }
    }
}

#endif
