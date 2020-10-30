import XcodeServer
import ProcedureKit
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class UpdateIntegrationIssuesProcedure: Procedure, InputProcedure {
    
    private let destination: IntegrationPersistable
    private let integration: Integration
    public var input: Pending<Integration.IssueCatalog> = .pending
    
    public init(destination: IntegrationPersistable, integration: Integration, input: Integration.IssueCatalog? = nil) {
        self.destination = destination
        self.integration = integration
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
            InternalLog.procedures.error("UpdateIntegrationIssuesProcedure Failed", error: error)
            finish(with: error)
            return
        }
        
        let id = integration.id
        
        destination.saveIssues(value, forIntegration: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                InternalLog.procedures.error("UpdateIntegrationIssuesProcedure Failed", error: error)
                self?.finish(with: error)
            case .success:
                NotificationCenter.default.postIntegrationDidChange(id)
                self?.finish()
            }
        }
    }
}
