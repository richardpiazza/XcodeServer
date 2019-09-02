import Foundation
import ProcedureKit
import XcodeServerAPI

public class GetBotStatsProcedure: APIClientProcedure, OutputProcedure {
    
    public typealias Output = XCSStats
    
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public override func performTask() {
        guard let id = input.value?.id else {
            output = .ready(.failure(XcodeServerProcedureError.invalidInput))
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        client.stats(forBotWithIdentifier: id) { [weak self] (result) in
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
