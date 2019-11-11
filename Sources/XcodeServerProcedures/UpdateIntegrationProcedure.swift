import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateIntegrationProcedure: NSManagedObjectProcedure<Integration>, InputProcedure, OutputProcedure {
    
    public typealias Input = XCSIntegration
    public typealias Output = [XcodeServerProcedureEvent]
    
    public var input: Pending<Input> = .pending
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public init(container: NSPersistentContainer, integration: Integration, input: Input? = nil) {
        super.init(container: container, object: integration)
        
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
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        let id = objectID
        
        print("Updating Integration '\(managedObject.identifier)'")
        
        container.performBackgroundTask { [weak self] (context) in
            let integration = context.object(with: id) as! Integration
            
            let events = integration.update(withIntegration: value)
            
            do {
                try context.save()
                self?.output = .ready(.success(events))
                self?.finish()
            } catch {
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}

#endif
