import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateServerBotsProcedure: NSManagedObjectProcedure<Server>, InputProcedure {
    
    public typealias Input = [XCSBot]
    
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
            cancel()
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        let id = objectID
        
        container.performBackgroundTask { [weak self] (context) in
            let server = context.object(with: id) as! Server
            
            server.update(withBots: value)
            server.lastUpdate = Date()
            
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
