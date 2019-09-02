import Foundation
import ProcedureKit
import XcodeServerAPI

public typealias FQDN = String
public typealias ID = String

open class APIClientProcedure: Procedure, InputProcedure {
    
    public typealias Input = (fqdn: FQDN, id: ID?)
    
    open var input: Pending<Input> = .pending
    public var client: APIClient!
    
    public init(input: Input? = nil) {
        super.init()
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    open override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let value = input.value else {
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        do {
            client = try APIClient.client(forFQDN: value.fqdn)
        } catch {
            finish(with: error)
            return
        }
        
        performTask()
    }
    
    open func performTask() {
        finish()
    }
}
