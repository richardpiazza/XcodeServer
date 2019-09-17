import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncIncompleteIntegrationsProcedure: NSPersistentContainerGroupProcedure {
    
    public init(container: NSPersistentContainer, apiClients: [String: APIClient]) {
        var operations: [Procedure] = []
        
        let incompleteIntegrations = container.viewContext.incompleteIntegrations()
        incompleteIntegrations.forEach({ (integration) in
            guard let fqdn = integration.bot?.server?.fqdn else {
                return
            }
            
            guard let apiClient = apiClients[fqdn] else {
                return
            }
            
            let get = GetIntegrationProcedure(client: apiClient, input: integration.identifier)
            let update = UpdateIntegrationProcedure(container: container, integration: integration)
            update.injectResult(from: get)
            
            operations.append(contentsOf: [get, update])
        })
        
        super.init(container: container, operations: operations)
    }
}

#endif
