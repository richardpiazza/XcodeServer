import Foundation
import ProcedureKit
import XcodeServerAPI

public class GetVersionProcedure: APIClientProcedure, OutputProcedure {
    
    public typealias Output = (XCSVersion, Int?)
    
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        print("Getting Version '\(client.baseURL)'")
        
        client.versions { [weak self] (result) in
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
