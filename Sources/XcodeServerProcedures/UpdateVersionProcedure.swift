import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateVersionProcedure: NSPersistentContainerProcedure, InputProcedure {
    
    public typealias Input = (version: XCSVersion, api: Int?)
    
    public var input: Pending<Input> = .pending
    
    private var server: Server {
        return object as! Server
    }
    
    public init(server: Server, input: Input? = nil) {
        super.init(object: server)
        
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let value = input.value else {
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        let objectId = server.objectID
        
        container.performBackgroundTask { [weak self] (context) in
            guard let object = context.object(with: objectId) as? Server else {
                self?.cancel()
                self?.finish(with: XcodeServerProcedureError.invalidManagedObjectID(id: objectId))
                return
            }
            
            object.lastUpdate = Date()
            object.update(withVersion: value.version, api: value.api)
            
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
