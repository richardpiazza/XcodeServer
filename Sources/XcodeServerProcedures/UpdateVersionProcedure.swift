import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateVersionProcedure: Procedure, InputProcedure {
    
    private let destination: ServerPersistable
    private var server: Server
    public var input: Pending<Server.Version> = .pending
    
    public init(destination: ServerPersistable, server: Server, input: Server.Version? = nil) {
        self.destination = destination
        self.server = server
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
            InternalLog.procedures.error("UpdateVersionProcedure Failed", error: error)
            finish(with: error)
            return
        }
        
        let id = server.id
        
        server.version = value
        
        destination.saveServer(server) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.procedures.error("UpdateVersionProcedure Failed", error: error)
                self?.finish(with: error)
            case .success:
                NotificationCenter.default.postServerDidChange(id)
                self?.finish()
            }
        }
    }
}
