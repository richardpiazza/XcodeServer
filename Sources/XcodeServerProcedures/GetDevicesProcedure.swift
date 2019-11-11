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
        
        print("Getting Devices '\(client.baseURL)'")
        
        client.get("devices") { [weak self] (statusCode, headers, data: Response?, error) in
            switch error {
            case .none:
                let value = data?.results ?? []
                self?.output = .ready(.success(value))
                self?.finish()
            case .some(let e):
                print(e)
                self?.output = .ready(.failure(e))
                self?.finish(with: e)
            }
        }
    }
}
