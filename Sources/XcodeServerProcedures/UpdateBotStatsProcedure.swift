import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateBotStatsProcedure: IdentifiablePersitableProcedure<Bot>, InputProcedure {
    
    public var input: Pending<Bot.Stats> = .pending
    
    public init(destination: AnyPersistable, identifiable: Bot, input: Bot.Stats? = nil) {
        super.init(destination: destination, identifiable: identifiable)
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
        
        print("Updating Stats for Bot '\(id)'")
        
        var _bot = identifiable
        _bot.stats = value
        
        destination.saveBot(_bot) { [weak self] (result) in
            switch result {
            case .success:
                self?.finish()
            case .failure(let error):
                self?.finish(with: error)
            }
        }
    }
}
