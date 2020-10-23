import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncIntegrationProcedure: GroupProcedure {
    
    let integration: Integration
    
    public init(source: IntegrationQueryable, destination: IntegrationPersistable, integration: Integration) {
        self.integration = integration
        super.init(operations: [])
        
        let get = GetIntegrationProcedure(source: source, input: integration.id)
        let update = UpdateIntegrationProcedure(destination: destination)
        update.injectResult(from: get)
        
        addChildren(get, update)
    }
}
