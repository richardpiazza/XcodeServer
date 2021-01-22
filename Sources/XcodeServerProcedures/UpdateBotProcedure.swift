import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateBotProcedure: Procedure, InputProcedure {
    
    private let destination: BotPersistable
    private let bot: Bot
    
    public var input: Pending<Bot> = .pending
    
    public init(destination: BotPersistable, bot: Bot, input: Bot? = nil) {
        self.destination = destination
        self.bot = bot
        super.init()
        
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
            InternalLog.operations.error("UpdateBotProcedure Failed", error: error)
            finish(with: error)
            return
        }
        
        guard let serverId = bot.serverId else {
            let error = XcodeServerProcedureError.invalidInput
            InternalLog.operations.error("UpdateBotProcedure Failed - No Server ID", error: error)
            finish(with: error)
            return
        }
        
        let id = bot.id
        
        destination.saveBot(value, forServer: serverId) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.operations.error("UpdateBotProcedure Failed", error: error)
                self?.finish(with: error)
            case .success:
                NotificationCenter.default.postBotDidChange(id)
                self?.finish()
            }
        }
    }
}
