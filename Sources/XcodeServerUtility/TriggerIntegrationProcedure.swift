import XcodeServer
import XcodeServerAPI
import XcodeServerProcedures
import ProcedureKit

class TriggerIntegrationProcedure: Procedure, InputProcedure, OutputProcedure {
    
    private let source: APIClient
    
    var input: Pending<Bot.ID> = .pending
    var output: Pending<ProcedureResult<[Integration]>> = .pending
    
    init(source: APIClient, input: Bot.ID? = nil) {
        self.source = source
        super.init()
        
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let id = input.value else {
            let error = XcodeServerProcedureError.invalidInput
            InternalLog.procedures.error("TriggerIntegrationProcedure Failed", error: error)
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        source.runIntegration(forBotWithIdentifier: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.procedures.error("TriggerIntegrationProcedure Failed", error: error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            case .success(let integration):
                let _integration = XcodeServer.Integration(integration, bot: id, server: nil)
                self?.output = .ready(.success([_integration]))
                self?.finish()
            }
        }
    }
}
