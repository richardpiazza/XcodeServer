import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateBotIntegrationsProcedure: IdentifiablePersitableProcedure<Bot>, InputProcedure, OutputProcedure {
    
    public var input: Pending<[Integration]> = .pending
    public var output: Pending<ProcedureResult<[XcodeServerProcedureEvent]>> = .pending
    
    public init(destination: AnyPersistable, identifiable: Bot, input: [Integration]? = nil) {
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
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        var _bot = identifiable
        _bot.modified = Date()
        value.forEach({ _bot.integrations.insert($0) })
        
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
