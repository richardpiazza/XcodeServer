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

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncIntegrationGroupProcedure: GroupProcedure, OutputProcedure {
    
    public typealias Source = IntegrationQueryable
    public typealias Destination = (IntegrationQueryable & IntegrationPersistable)
    
    public var output: Pending<ProcedureResult<Integration>> = .pending
    
    public init(source: Source, destination: Destination, integration: Integration) {
        super.init(operations: [])
        
        let getFromSource = GetIntegrationProcedure(source: source, input: integration.id)
        let updateAtDestination = UpdateIntegrationProcedure(destination: destination)
        updateAtDestination.injectResult(from: getFromSource)
        let getUpdatedIntegration = GetIntegrationProcedure(source: destination, input: integration.id)
        getUpdatedIntegration.addDependency(updateAtDestination)
        getUpdatedIntegration.addWillFinishBlockObserver { (proc, error, event) in
            self.output = proc.output
        }
        
        addChildren([getFromSource, updateAtDestination, getUpdatedIntegration])
    }
}
