import Foundation
import ProcedureKit
import XcodeServerAPI

public class TriggerBotIntegrationProcedure: APIClientProcedure, InputProcedure, OutputProcedure {
    
    public typealias Input = String
    public typealias Output = XCSIntegration
    
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
            output = .ready(.failure(XcodeServerProcedureError.invalidInput))
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        print("Trigger Integration for Bot '\(id)'")
        
        client.runIntegration(forBotWithIdentifier: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            }
        }
    }
}