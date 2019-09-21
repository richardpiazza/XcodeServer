import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class UpdateBotProcedure: NSManagedObjectProcedure<Bot>, InputProcedure, OutputProcedure {
    
    public typealias Input = XCSBot
    public typealias Output = [XcodeServerProcedureEvent]
    
    public var input: Pending<Input> = .pending
    public var output: Pending<ProcedureResult<Output>> = .pending
    
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
        
        print("Updating Bot '\(managedObject.identifier)'")
        
        container.performBackgroundTask { [weak self] (context) in
            let bot = context.object(with: id) as! Bot
            
            let events = bot.update(withBot: value)
            bot.lastUpdate = Date()
            
            do {
                try context.save()
                self?.output = .ready(.success(events))
                self?.finish()
            } catch {
                print(error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}

#endif
