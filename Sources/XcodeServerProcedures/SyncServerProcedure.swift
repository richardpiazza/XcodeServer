import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncServerProcedure: Procedure {
    
    private let source: AnyQueryable
    private let destination: AnyPersistable
    private let server: Server
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public init(source: AnyQueryable, destination: AnyPersistable, server: Server) {
        self.source = source
        self.destination = destination
        self.server = server
        super.init()
        
        procedureQueue.delegate = self
        procedureQueue.maxConcurrentOperationCount = 1
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        let version = SyncVersionProcedure(source: source, destination: destination, server: server)
        let bots = SyncServerBotsProcedure(source: source, destination: destination, server: server)
        bots.addDependency(version)
        
        procedureQueue.addOperations([version, bots])
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
extension SyncServerProcedure: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        switch procedure {
        case is SyncVersionProcedure:
            break
        case is SyncServerBotsProcedure:
            guard error == nil else {
                print(error!)
                break
            }
            
            let sync = procedure as! SyncServerBotsProcedure
            sync.bots?.forEach({ (bot) in
                let stats = SyncBotStatsProcedure(source: source, destination: destination, bot: bot)
                let next = SyncBotIntegrationsProcedure(source: source, destination: destination, bot: bot)
                next.addDependency(stats)
                queue.addOperations([stats, next])
            })
        case is SyncBotIntegrationsProcedure:
            guard error == nil else {
                print(error!)
                break
            }
            
            let sync = procedure as! SyncBotIntegrationsProcedure
            sync.integrations?.forEach({ (integration) in
                let next = SyncIntegrationProcedure(source: source, destination: destination, integration: integration)
                queue.addOperation(next)
            })
        case is SyncIntegrationProcedure:
            guard error == nil else {
                print(error!)
                break
            }
            
            let sync = procedure as! SyncIntegrationProcedure
            let issues = SyncIntegrationIssuesProcedure(source: source, destination: destination, integration: sync.integration)
            let commits = SyncIntegrationCommitsProcedure(source: source, destination: destination, integration: sync.integration)

            queue.addOperations([issues, commits])
        default:
            break
        }
        
        if queue.operationCount == 0 {
            finish()
        }
    }
}
