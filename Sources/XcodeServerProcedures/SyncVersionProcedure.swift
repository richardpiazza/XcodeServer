import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncVersionProcedure: GroupProcedure {
    
    public init(source: ServerQueryable, destination: ServerPersistable, server: Server) {
        let get = GetVersionProcedure(source: source, input: server.id)
        let update = UpdateVersionProcedure(destination: destination, server: server)
        update.injectResult(from: get)
        
        super.init(operations: [get, update])
    }
}
