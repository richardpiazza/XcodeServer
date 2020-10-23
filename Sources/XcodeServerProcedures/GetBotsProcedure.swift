import XcodeServer
import ProcedureKit

public class GetBotsProcedure: Procedure, OutputProcedure {
    
    private let source: BotQueryable
    
    public var output: Pending<ProcedureResult<[Bot]>> = .pending
    
    public init(source: BotQueryable) {
        self.source = source
        super.init()
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        source.getBots { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            case .failure(let error):
                InternalLog.procedures.error("GetBotsProcedure Failed", error: error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
