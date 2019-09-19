import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncIntegrationIssuesProcedure: NSManagedObjectGroupProcedure<Integration> {
    
    public let apiClient: APIClient
    
    public init(container: NSPersistentContainer, integration: Integration, apiClient: APIClient) {
        self.apiClient = apiClient
        
        let get = GetIntegrationIssuesProcedure(client: apiClient, input: integration.identifier)
        
        let update = UpdateIntegrationIssuesProcedure(container: container, integration: integration)
        update.injectResult(from: get)
        
        super.init(container: container, object: integration, operations: [get, update])
    }
}

#endif
