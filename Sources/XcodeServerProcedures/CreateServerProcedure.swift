import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class CreateServerProcedure: Procedure, InputProcedure {
    
    private let destination: ServerPersistable
    
    public var input: Pending<Server.ID> = .pending
    
    public init(destination: ServerPersistable, input: Input? = nil) {
        self.destination = destination
        super.init()
        
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let value = input.value else {
            let error = XcodeServerProcedureError.invalidInput
            InternalLog.procedures.error("CreateServerProcedure Failed", error: error)
            finish(with: error)
            return
        }
        
        let server = Server(id: value)
        
        destination.saveServer(server) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.procedures.error("CreateServerProcedure Failed", error: error)
                self?.finish(with: error)
            case .success:
                NotificationCenter.default.postServersDidChange()
                self?.finish()
            }
        }
    }
}
