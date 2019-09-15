import Foundation
import ProcedureKit
import XcodeServerAPI

public class GetDevicesProcedure: APIClientProcedure, OutputProcedure {
    
    struct Response: Codable {
        var count: Int
        var results: [XCSDevice]
    }
    
    public typealias Output = [XCSDevice]
    
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        client.get("devices") { [weak self] (statusCode, headers, data: Response?, error) in
            guard error == nil else {
                self?.output = .ready(.failure(error!))
                self?.finish(with: error!)
                return
            }
            
            let value = data?.results ?? []
            self?.output = .ready(.success(value))
            self?.finish()
        }
    }
}
