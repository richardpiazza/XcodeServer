import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateBotProcedure: NSPersistentContainerProcedure, InputProcedure {
    
    public typealias Input = XCSBot
    
    public var input: Pending<Input> = .pending
    
    private var bot: Bot {
        return object as! Bot
    }
    
    public init(bot: Bot, input: Input? = nil) {
        super.init(object: bot)
        
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
        
        let objectId = bot.objectID
        
        container.performBackgroundTask { [weak self] (context) in
            guard let object = context.object(with: objectId) as? Bot else {
                self?.cancel()
                self?.finish(with: XcodeServerProcedureError.invalidManagedObjectID(id: objectId))
                return
            }
            
            object.update(withBot: value)
            
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
