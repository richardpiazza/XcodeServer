import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class CreateIntegrationProcedure: Procedure, InputProcedure {
    
    private let destination: BotPersistable
    private var bot: Bot
    public var input: Pending<Integration> = .pending
    
    public init(destination: BotPersistable, bot: Bot, input: Integration? = nil) {
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
            InternalLog.procedures.error("CreateIntegrationProcedure Failed", error: error)
            finish(with: error)
            return
        }
        
        let id = bot.id
        
        bot.integrations.insert(value)
        
        destination.saveBot(bot) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.procedures.error("CreateIntegrationProcedure Failed", error: error)
                self?.finish(with: error)
            case .success:
                NotificationCenter.default.postBotDidChange(id)
                self?.finish()
            }
        }
    }
}
