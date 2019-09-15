import Foundation
import ProcedureKit
import XcodeServerAPI

public class GetBotProcedure: APIClientProcedure, InputProcedure, OutputProcedure {
    
    public typealias Input = String
    public typealias Output = XCSBot
    
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
        
        client.bot(withIdentifier: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            case .success(let value):
                self?.output = .ready(.success(value))
                self?.finish()
            }
        }
    }
}
