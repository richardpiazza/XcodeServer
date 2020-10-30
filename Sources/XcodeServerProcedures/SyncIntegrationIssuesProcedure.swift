import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncIntegrationIssuesProcedure: GroupProcedure {
    
    public init(source: IntegrationQueryable, destination: IntegrationPersistable, integration: Integration) {
        super.init(operations: [])
        
        let get = GetIntegrationIssuesProcedure(source: source, input: integration.id)
        let update = UpdateIntegrationIssuesProcedure(destination: destination, integration: integration)
        update.injectResult(from: get)
        
        addChildren([get, update])
    }
}
