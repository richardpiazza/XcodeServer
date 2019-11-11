import Foundation
import ProcedureKit
import XcodeServerAPI

public class GetBotIntegrationsProcedure: APIClientProcedure, InputProcedure, OutputProcedure {
    
    public typealias Input = String
    public typealias Output = [XCSIntegration]
    
    public var input: Pending<Input> = .pending
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public init(client: APIClient, input: Input? = nil) {
        super.init(client: client)
        
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
        
        print("Getting Integrations for Bot '\(id)'")
        
        client.integrations(forBotWithIdentifier: id) { [weak self] (result) in
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
