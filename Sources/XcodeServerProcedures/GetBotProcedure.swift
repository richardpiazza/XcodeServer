import XcodeServer
import ProcedureKit

public class GetBotProcedure: Procedure, InputProcedure, OutputProcedure {
    
    private let source: BotQueryable
    
    public var input: Pending<Bot.ID> = .pending
    public var output: Pending<ProcedureResult<Bot>> = .pending
    
    public init(source: BotQueryable, input: Bot.ID? = nil) {
        self.source = source
        super.init()
        
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
            InternalLog.procedures.error("GetBotProcedure Failed", error: error)
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        source.getBot(id) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            case .failure(let error):
                InternalLog.procedures.error("GetBotProcedure Failed", error: error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
