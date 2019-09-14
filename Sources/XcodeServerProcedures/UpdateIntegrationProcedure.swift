import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateIntegrationProcedure: NSManagedObjectProcedure<Integration>, InputProcedure {
    
    public typealias Input = XCSIntegration
    
    public var input: Pending<Input> = .pending
    
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
            cancel()
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        let id = objectID
        
        container.performBackgroundTask { [weak self] (context) in
            let integration = context.object(with: id) as! Integration
            
            integration.update(withIntegration: value)
            
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
