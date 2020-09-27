import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateIntegrationIssuesProcedure: IdentifiablePersitableProcedure<Integration>, InputProcedure {
    
    public var input: Pending<Integration.IssueCatalog> = .pending
    
    public init(destination: AnyPersistable, identifiable: Integration, input: Integration.IssueCatalog? = nil) {
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
            cancel(with: error)
            finish(with: error)
            return
        }
        
        print("Updating Issues for Integration '\(id)'")
        
        destination.saveIssues(value, forIntegration: id) { [weak self] (result) in
            switch result {
            case .success:
                self?.finish()
            case .failure(let error):
                self?.finish(with: error)
            }
        }
    }
}
