import XcodeServer
import ProcedureKit

public class GetBotProcedure: AnyQueryableProcedure, InputProcedure, OutputProcedure {
    
    public var input: Pending<Bot.ID> = .pending
    public var output: Pending<ProcedureResult<Bot>> = .pending
    
    public init(source: AnyQueryable, input: Bot.ID? = nil) {
        super.init(source: source)
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let id = input.value else {
            let error = XcodeServerProcedureError.invalidInput
            cancel(with: error)
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        print("Getting Bot '\(id)'")
        
        source.getBot(id) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            case .failure(let error):
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
