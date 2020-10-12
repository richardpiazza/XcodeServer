import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class CreateIntegrationProcedure: IdentifiablePersitableProcedure<Bot>, InputProcedure {
    
    public var input: Pending<Integration> = .pending
    
    public init(destination: AnyPersistable, identifiable: Bot, input: Integration? = nil) {
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
            InternalLog.procedures.error("", error: error)
            cancel(with: error)
            finish(with: error)
            return
        }
        
        var _bot = identifiable
        _bot.integrations.insert(value)
        
        destination.saveBot(_bot) { [weak self] (result) in
            switch result {
            case .success:
                self?.finish()
            case .failure(let error):
                InternalLog.procedures.error("", error: error)
                self?.finish(with: error)
            }
        }
    }
}
