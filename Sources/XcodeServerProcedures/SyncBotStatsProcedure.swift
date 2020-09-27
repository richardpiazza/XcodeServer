import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncBotStatsProcedure: IdentifiablePersitableGroupProcedure<Bot> {
    
    public let source: AnyQueryable
    
    public init(source: AnyQueryable, destination: AnyPersistable, identifiable: Bot) {
        self.source = source
        
        let get = GetBotStatsProcedure(source: source, input: identifiable.id)
        let update = UpdateBotStatsProcedure(destination: destination, identifiable: identifiable)
        update.injectResult(from: get)
        
        super.init(destination: destination, identifiable: identifiable, operations: [get, update])
    }
}
