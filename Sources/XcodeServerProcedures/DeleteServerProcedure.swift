import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class DeleteServerProcedure: IdentifiablePersitableProcedure<Server> {
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        print("Deleting Server '\(id)'")
        
        destination.deleteServer(identifiable) { [weak self] (result) in
            switch result {
            case .success:
                self?.finish()
            case .failure(let error):
                self?.finish(with: error)
            }
        }
    }
}
