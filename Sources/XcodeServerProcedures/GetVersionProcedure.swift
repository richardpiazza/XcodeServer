import XcodeServer
import ProcedureKit

public class GetVersionProcedure: AnyQueryableProcedure, InputProcedure, OutputProcedure {
    
    public var input: Pending<Server.ID> = .pending
    public var output: Pending<ProcedureResult<Server.Version>> = .pending
    
    public init(source: AnyQueryable, input: Server.ID? = nil) {
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
        
        source.getServer(id) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.output = .ready(.success(value.version))
                self?.finish()
            case .failure(let error):
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
