import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncServerBotsProcedure: GroupProcedure {
    
    /// Bots retrieved from the queryable source.
    public var bots: [Bot]?
    
    public init(source: BotQueryable, destination: ServerPersistable, server: Server) {
        super.init(operations: [])
        
        let get = GetBotsProcedure(source: source)
        get.addDidFinishBlockObserver { (proc, error) in
            self.bots = proc.output.success
        }
        let update = UpdateServerBotsProcedure(destination: destination, server: server)
        update.injectResult(from: get)
        
        addChildren(get, update)
    }
}
