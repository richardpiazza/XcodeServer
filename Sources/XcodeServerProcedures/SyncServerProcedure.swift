import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class SyncServerProcedure: NSManagedObjectProcedure<Server> {
    
    public let apiClient: APIClient
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public init(container: NSPersistentContainer, server: Server, apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(container: container, object: server)
        procedureQueue.delegate = self
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        let version = SyncVersionProcedure(container: container, server: managedObject, apiClient: apiClient)
        let bots = SyncServerBotsProcedure(container: container, server: managedObject, apiClient: apiClient)
        bots.addDependency(version)
        
        procedureQueue.addOperations([version, bots])
    }
}

extension SyncServerProcedure: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        switch procedure {
        case is SyncVersionProcedure:
            return
        case is SyncServerBotsProcedure:
            guard error == nil else {
                print(error!)
                return
            }
            
            let sync = procedure as! SyncServerBotsProcedure
            let server = container.viewContext.object(with: sync.objectID) as! Server
            for bot in (server.bots ?? []) {
                let stats = SyncBotStatsProcedure(container: container, bot: bot, apiClient: sync.apiClient)
                let next = SyncBotIntegrationsProcedure(container: container, bot: bot, apiClient: sync.apiClient)
                next.addDependency(stats)
                queue.addOperations([stats, next])
            }
            
            return
        case is SyncBotIntegrationsProcedure:
            guard error == nil else {
                print(error!)
                return
            }
            
            let sync = procedure as! SyncBotIntegrationsProcedure
            let bot = container.viewContext.object(with: sync.objectID) as! Bot
            for integration in (bot.integrations ?? []) {
                let next = SyncIntegrationProcedure(container: container, integration: integration, apiClient: sync.apiClient)
                queue.addOperation(next)
            }
            
            return
        case is SyncIntegrationProcedure:
            guard error == nil else {
                print(error!)
                return
            }
            
            let sync = procedure as! SyncIntegrationProcedure
            let integration = container.viewContext.object(with: sync.objectID) as! Integration
            
            let issues = SyncIntegrationIssuesProcedure(container: container, integration: integration, apiClient: sync.apiClient)
            let commits = SyncIntegrationCommitsProcedure(container: container, integration: integration, apiClient: sync.apiClient)
            
            queue.addOperations([issues, commits])
            
            return
        default:
            break
        }
        
        if queue.operationCount == 0 {
            self.finish()
        }
    }
}

#endif
