import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncServerBotsProcedure: NSManagedObjectGroupProcedure<Server> {
    
    public let apiClient: APIClient
    
    public init(container: NSPersistentContainer, server: Server, apiClient: APIClient) {
        self.apiClient = apiClient
        
        let get = GetBotsProcedure(client: apiClient)
        
        let update = UpdateServerBotsProcedure(container: container, server: server)
        update.injectResult(from: get)
        
        super.init(container: container, object: server, operations: [get, update])
    }
}

#endif
