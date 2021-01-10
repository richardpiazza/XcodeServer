import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateIntegrationProcedure: Procedure, InputProcedure {
    
    private let destination: IntegrationPersistable
    
    public var input: Pending<Integration> = .pending
    
    public init(destination: IntegrationPersistable, input: Integration? = nil) {
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
            InternalLog.operations.error("UpdateIntegrationProcedure Failed", error: error)
            finish(with: error)
            return
        }
        
        guard let botId = value.botId else {
            let error = XcodeServerProcedureError.invalidInput
            InternalLog.operations.error("UpdateIntegrationProcedure Failed - No Bot ID", error: error)
            finish(with: error)
            return
        }
        
        let id = value.id
        
        destination.saveIntegration(value, forBot: botId) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.operations.error("UpdateIntegrationProcedure Failed", error: error)
                self?.finish(with: error)
            case .success:
                NotificationCenter.default.postIntegrationDidChange(id)
                self?.finish()
            }
        }
    }
}
