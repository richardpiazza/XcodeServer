import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncBotIntegrationsProcedure: NSManagedObjectGroupProcedure<Bot> {
    
    public let apiClient: APIClient
    
    public init(container: NSPersistentContainer, bot: Bot, apiClient: APIClient) {
        self.apiClient = apiClient
        
        let get = GetBotIntegrationsProcedure(client: apiClient)
        
        let update = UpdateBotIntegrationsProcedure(container: container, bot: bot)
        update.injectResult(from: get)
        
        super.init(container: container, object: bot, operations: [get, update])
    }
}

#endif
