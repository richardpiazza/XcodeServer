import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class DeleteServerProcedure: IdentifiablePersitableProcedure<Server> {
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        destination.deleteServer(identifiable) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.procedures.error("", error: error)
                self?.finish(with: error)
            case .success:
                NotificationCenter.default.postServersDidChange()
                self?.finish()
            }
        }
    }
}
