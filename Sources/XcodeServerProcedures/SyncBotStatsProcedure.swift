import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncBotStatsProcedure: GroupProcedure {
    
    public init(source: BotQueryable, destination: BotPersistable, bot: Bot) {
        super.init(operations: [])
        
        let get = GetBotStatsProcedure(source: source, input: bot.id)
        let update = UpdateBotStatsProcedure(destination: destination, bot: bot)
        update.injectResult(from: get)
        
        addChildren([get, update])
    }
}
