import XcodeServer
import ProcedureKit

public class GetBotsProcedure: AnyQueryableProcedure, OutputProcedure {
    
    public var output: Pending<ProcedureResult<[Bot]>> = .pending
    
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
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
