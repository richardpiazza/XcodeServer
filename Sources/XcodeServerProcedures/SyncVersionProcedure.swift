import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncVersionProcedure: IdentifiablePersitableGroupProcedure<Server> {
    
    public let source: AnyQueryable
    
    public init(source: AnyQueryable, destination: AnyPersistable, identifiable: Server) {
        self.source = source
        
        let get = GetVersionProcedure(source: source, input: identifiable.id)
        let update = UpdateVersionProcedure(destination: destination, identifiable: identifiable)
        update.injectResult(from: get)
        
        super.init(destination: destination, identifiable: identifiable, operations: [get, update])
    }
}
