import Foundation
import ProcedureKit
import XcodeServerAPI

open class APIClientProcedure: Procedure {
    
    public let client: APIClient
    
    public init(client: APIClient) {
        self.client = client
        super.init()
        
    }
}
