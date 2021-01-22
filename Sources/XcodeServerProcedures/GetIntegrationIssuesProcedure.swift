import XcodeServer
import ProcedureKit

public class GetIntegrationIssuesProcedure: Procedure, InputProcedure, OutputProcedure {
    
    private let source: IntegrationQueryable
    
    public var input: Pending<Integration.ID> = .pending
    public var output: Pending<ProcedureResult<Integration.IssueCatalog>> = .pending
    
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
            InternalLog.operations.error("GetIntegrationIssuesProcedure Failed", error: error)
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        InternalLog.operations.debug("Getting ISSUES from Integration [\(id)]")
        
        source.getIssuesForIntegration(id) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            case .failure(let error):
                InternalLog.operations.error("GetIntegrationIssuesProcedure Failed", error: error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        }
    }
}
