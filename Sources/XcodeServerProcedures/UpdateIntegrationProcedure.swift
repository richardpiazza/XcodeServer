import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateIntegrationProcedure: IdentifiablePersitableProcedure<Integration>, InputProcedure {
    
    public var input: Pending<Integration> = .pending
    
    public init(destination: AnyPersistable, identifiable: Integration, input: Integration? = nil) {
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
        
        destination.saveIntegration(value) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.procedures.error("", error: error)
                self?.finish(with: error)
            case .success:
                if let id = self?.identifiable.id {
                    NotificationCenter.default.postIntegrationDidChange(id)
                }
                self?.finish()
            }
        }
    }
}
