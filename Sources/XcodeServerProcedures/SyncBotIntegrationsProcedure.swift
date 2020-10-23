import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncBotIntegrationsProcedure: GroupProcedure {
    
    public var integrations: [Integration]?
    
    public init(source: IntegrationQueryable, destination: BotPersistable, bot: Bot) {
        super.init(operations: [])
        
        let get = GetBotIntegrationsProcedure(source: source, input: bot.id)
        get.addDidFinishBlockObserver { (proc, error) in
            self.integrations = proc.output.success
        }
        let update = UpdateBotIntegrationsProcedure(destination: destination, bot: bot)
        update.injectResult(from: get)
        
        addChildren(get, update)
    }
}
