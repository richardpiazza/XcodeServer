import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateServerBotsProcedure: Procedure, InputProcedure {
    
    private let destination: ServerPersistable
    private var server: Server
    
    public var input: Pending<[Bot]> = .pending
    
    public init(destination: ServerPersistable, server: Server, input: [Bot]? = nil) {
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
            InternalLog.operations.error("UpdateServerBotsProcedure Failed", error: error)
            finish(with: error)
            return
        }
        
        let id = server.id
        
        destination.saveBots(value, forServer: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.operations.error("UpdateServerBotsProcedure Failed", error: error)
                self?.finish(with: error)
            case .success(_):
                NotificationCenter.default.postServerDidChange(id)
                self?.finish()
            }
        }
    }
}
