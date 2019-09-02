import Foundation
import ProcedureKit
import XcodeServerAPI

public class CheckConnectionProcedure: APIClientProcedure, OutputProcedure {
    
    public typealias Output = Bool
    
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public override func performTask() {
        client.ping { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            case .success:
                self?.output = .ready(.success(true))
                self?.finish()
            }
        }
    }
}
