import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateServerBotsProcedure: IdentifiablePersitableProcedure<Server>, InputProcedure {
    
    public var input: Pending<[Bot]> = .pending
    
    public init(destination: AnyPersistable, identifiable: Server, input: [Bot]? = nil) {
        super.init(destination: destination, identifiable: identifiable)
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
            InternalLog.procedures.error("", error: error)
            cancel(with: error)
            finish(with: error)
            return
        }
        
        var _server = identifiable
        value.forEach({ _server.bots.insert($0) })
        
        destination.saveServer(_server) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.finish()
            case .failure(let error):
                InternalLog.procedures.error("", error: error)
                self?.finish(with: error)
            }
        }
    }
}
