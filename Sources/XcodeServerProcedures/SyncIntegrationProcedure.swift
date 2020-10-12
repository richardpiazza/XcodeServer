import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncIntegrationProcedure: IdentifiablePersitableGroupProcedure<Integration> {
    
    public let source: AnyQueryable
    
    public init(source: AnyQueryable, destination: AnyPersistable, identifiable: Integration) {
        self.source = source
        super.init(destination: destination, identifiable: identifiable, operations: [])
        
        let get = GetIntegrationProcedure(source: source, input: identifiable.id)
        let update = UpdateIntegrationProcedure(destination: destination, identifiable: identifiable)
        update.injectResult(from: get)
        
        addChildren(get, update)
    }
}
