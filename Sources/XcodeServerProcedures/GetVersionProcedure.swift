import XcodeServer
import ProcedureKit

public class GetVersionProcedure: Procedure, InputProcedure, OutputProcedure {
    
    private let source: ServerQueryable
    
    public var input: Pending<Server.ID> = .pending
    public var output: Pending<ProcedureResult<Server.Version>> = .pending
    
    public init(source: ServerQueryable, input: Server.ID? = nil) {
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
            InternalLog.operations.error("GetVersionProcedure Failed", error: error)
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
                InternalLog.operations.error("GetVersionProcedure Failed", error: error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
