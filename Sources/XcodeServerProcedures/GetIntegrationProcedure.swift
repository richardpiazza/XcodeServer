import XcodeServer
import ProcedureKit

public class GetIntegrationProcedure: Procedure, InputProcedure, OutputProcedure {
    
    private let source: IntegrationQueryable
    
    public var input: Pending<Integration.ID> = .pending
    public var output: Pending<ProcedureResult<Integration>> = .pending
    
    public init(source: IntegrationQueryable, input: Integration.ID? = nil) {
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
            InternalLog.procedures.error("GetIntegrationProcedure Failed", error: error)
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        source.getIntegration(id) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            case .failure(let error):
                InternalLog.procedures.error("GetIntegrationProcedure Failed", error: error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
