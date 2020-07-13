import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class CreateIntegrationProcedure: NSManagedObjectProcedure<Bot>, InputProcedure {
    
    public typealias Input = XCSIntegration
    
    public var input: Pending<Input> = .pending
    
    public init(container: NSPersistentContainer, bot: Bot, input: Input? = nil) {
        super.init(container: container, object: bot)
        
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
        
        print("Creating Integration '\(value.id)' for Bot  '\(managedObject.identifier)'")
        
        container.performBackgroundTask { [weak self] (context) in
            let bot = context.object(with: id) as! Bot
            
            guard let integration = Integration(managedObjectContext: context, identifier: value.id, bot: bot) else {
                self?.finish(with: XcodeServerProcedureError.failedToCreateIntegration(id: value.id))
                return
            }
            
            bot.addToIntegrations(integration)
            bot.lastUpdate = Date()
            
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
