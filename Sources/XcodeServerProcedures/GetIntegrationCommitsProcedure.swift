import XcodeServer
import ProcedureKit

public class GetIntegrationCommitsProcedure: AnyQueryableProcedure, InputProcedure, OutputProcedure {
    
    public var input: Pending<Integration.ID> = .pending
    public var output: Pending<ProcedureResult<[SourceControl.Commit]>> = .pending
    
    public init(source: AnyQueryable, input: Integration.ID? = nil) {
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
            InternalLog.procedures.error("", error: error)
            cancel(with: error)
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        source.getCommitsForIntegration(id) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            case .failure(let error):
                InternalLog.procedures.error("", error: error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
