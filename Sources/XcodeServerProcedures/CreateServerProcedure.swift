import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class CreateServerProcedure: IdentifiablePersitableProcedure<Server>, InputProcedure, OutputProcedure {
    
    public var input: Pending<Server.ID> = .pending
    public var output: Pending<ProcedureResult<[XcodeServerProcedureEvent]>> = .pending
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        XcodeServerProcedureEvent.log(.server(action: .create, id: identifiable.id))
        
        destination.saveServer(identifiable) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            case .success:
                self?.output = .ready(.success([]))
                self?.finish()
            }
        }
    }
}
