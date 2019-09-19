import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateBotStatsProcedure: NSManagedObjectProcedure<Bot>, InputProcedure {
    
    public typealias Input = XCSStats
    
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
            cancel()
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        let id = objectID
        
        print("Updating Stats for Bot '\(managedObject.identifier)'")
        
        container.performBackgroundTask { [weak self] (context) in
            let bot = context.object(with: id) as! Bot
            
            bot.stats?.update(withStats: value)
            
            do {
                try context.save()
                self?.finish()
            } catch {
                print(error)
                self?.finish(with: error)
            }
        }
    }
}

#endif
