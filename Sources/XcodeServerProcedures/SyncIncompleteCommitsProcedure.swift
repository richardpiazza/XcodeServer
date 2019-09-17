import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncIncompleteCommitsProcedure: NSPersistentContainerGroupProcedure {
    
    public init(container: NSPersistentContainer, apiClients: [String: APIClient]) {
        var operations: [Procedure] = []
        
        let incompleteCommits = container.viewContext.incompleteCommits()
        incompleteCommits.forEach({ (commit) in
            guard let revisionBlueprints = commit.revisionBlueprints else {
                return
            }
            
            for blueprint in revisionBlueprints {
                guard let integration = blueprint.integration else {
                    return
                }
                
                guard let fqdn = integration.bot?.server?.fqdn else {
                    return
                }
                
                guard let apiClient = apiClients[fqdn] else {
                    return
                }
                
                let get = GetIntegrationCommitsProcedure(client: apiClient, input: integration.identifier)
                let update = UpdateIntegrationCommitsProcedure(container: container, integration: integration)
                update.injectResult(from: get)
                
                operations.append(contentsOf: [get, update])
            }
        })
        
        super.init(container: container, operations: operations)
    }
}

#endif
