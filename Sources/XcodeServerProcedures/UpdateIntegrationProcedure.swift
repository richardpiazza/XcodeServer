import Foundation
import CoreData
import ProcedureKit
import XcodeServerAPI
import XcodeServerCoreData

public class UpdateIntegrationProcedure: NSPersistentContainerProcedure, InputProcedure {
    
    public typealias Input = XCSIntegration
    
    public var input: Pending<Input> = .pending
    
    private var integration: Integration {
        return object as! Integration
    }
    
    public init(integration: Integration, input: Input? = nil) {
        super.init(object: integration)
        
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
        
        let objectId = integration.objectID
        
        container.performBackgroundTask { [weak self] (context) in
            guard let object = context.object(with: objectId) as? Integration else {
                self?.cancel()
                self?.finish(with: XcodeServerProcedureError.invalidManagedObjectID(id: objectId))
                return
            }
            
            object.update(withIntegration: value)
            
            do {
                try context.save()
                self?.finish()
            } catch {
                self?.finish(with: error)
            }
        }
    }
}
