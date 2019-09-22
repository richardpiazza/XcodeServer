import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncIntegrationProcedure: NSManagedObjectGroupProcedure<Integration>, OutputProcedure {
    
    public typealias Output = [XcodeServerProcedureEvent]
    
    public let apiClient: APIClient
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public init(container: NSPersistentContainer, integration: Integration, apiClient: APIClient) {
        self.apiClient = apiClient
        
        let get = GetIntegrationProcedure(client: apiClient, input: integration.identifier)
        
        let update = UpdateIntegrationProcedure(container: container, integration: integration)
        update.injectResult(from: get)
        
        super.init(container: container, object: integration, operations: [get, update])
        
        update.addDidFinishBlockObserver { (proc, error) in
            self.output = proc.output
        }
    }
}

#endif
