import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncBotIntegrationsProcedure: IdentifiablePersitableGroupProcedure<Bot> {
    
    public let source: AnyQueryable
    public var integrations: [Integration]?
    
    public init(source: AnyQueryable, destination: AnyPersistable, identifiable: Bot) {
        self.source = source
        super.init(destination: destination, identifiable: identifiable, operations: [])
        
        let get = GetBotIntegrationsProcedure(source: source, input: identifiable.id)
        get.addDidFinishBlockObserver { (proc, error) in
            self.integrations = proc.output.success
        }
        let update = UpdateBotIntegrationsProcedure(destination: destination, identifiable: identifiable)
        update.injectResult(from: get)
        
        addChildren(get, update)
    }
}
