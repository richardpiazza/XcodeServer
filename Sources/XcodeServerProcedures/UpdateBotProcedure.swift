import Foundation
import CoreData
import ProcedureKit
import XcodeServerAPI
import XcodeServerCoreData

public class UpdateBotProcedure: Procedure, InputProcedure {
    
    public typealias Input = XCSBot
    
    public var input: Pending<Input> = .pending
    
    private var bot: Bot
    private var container: NSPersistentContainer = .xcodeServerCoreData
    
    public init(bot: Bot, input: Input? = nil) {
        self.bot = bot
        
        super.init()
        
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    
}
