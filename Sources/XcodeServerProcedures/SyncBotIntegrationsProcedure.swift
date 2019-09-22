import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncBotIntegrationsProcedure: NSManagedObjectGroupProcedure<Bot>, OutputProcedure {
    
    public typealias Output = [XcodeServerProcedureEvent]
    
    public let apiClient: APIClient
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public init(container: NSPersistentContainer, bot: Bot, apiClient: APIClient) {
        self.apiClient = apiClient
        
        let get = GetBotIntegrationsProcedure(client: apiClient, input: bot.identifier)
        
        let update = UpdateBotIntegrationsProcedure(container: container, bot: bot)
        update.injectResult(from: get)
        
        super.init(container: container, object: bot, operations: [get, update])
        
        update.addDidFinishBlockObserver { (proc, error) in
            self.output = proc.output
        }
    }
}

#endif
