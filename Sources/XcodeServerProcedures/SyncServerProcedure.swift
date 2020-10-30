import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncServerProcedure: Procedure {
    
    public typealias Source = AnyQueryable
    public typealias Destination = (AnyQueryable & AnyPersistable)
    
    private let source: Source
    private let destination: Destination
    private let server: Server
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public init(source: Source, destination: Destination, server: Server) {
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
        
        let syncVersion = SyncVersionProcedure(source: source, destination: destination, server: server)
        let syncBots = SyncServerBotsGroupProcedure(source: source, destination: destination, server: server)
        procedureQueue.addOperations([syncVersion, syncBots])
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
extension SyncServerProcedure: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        switch procedure {
        case is SyncVersionProcedure:
            break
        case is SyncServerBotsGroupProcedure:
            let proc = procedure as! SyncServerBotsGroupProcedure
            if let bots = proc.output.value?.value {
                for bot in bots {
                    let syncStats = SyncBotStatsProcedure(source: source, destination: destination, bot: bot)
                    let syncIntegrations = SyncBotIntegrationsGroupProcedure(source: source, destination: destination, bot: bot)
                    queue.addOperations([syncStats, syncIntegrations])
                }
            }
        case is SyncBotIntegrationsGroupProcedure:
            let proc = procedure as! SyncBotIntegrationsGroupProcedure
            if let integrations = proc.output.value?.value {
                for integration in integrations {
                    if integration.step != .completed {
                        let syncIntegration = SyncIntegrationGroupProcedure(source: source, destination: destination, integration: integration)
                        queue.addOperation(syncIntegration)
                    } else {
                        if integration.shouldRetrieveIssues {
                            let syncIssues = SyncIntegrationIssuesProcedure(source: source, destination: destination, integration: integration)
                            queue.addOperation(syncIssues)
                        }
                        if integration.shouldRetrieveCommits {
                            let syncCommits = SyncIntegrationCommitsProcedure(source: source, destination: destination, integration: integration)
                            queue.addOperation(syncCommits)
                        }
                    }
                }
            }
        case is SyncIntegrationGroupProcedure:
            let proc = procedure as! SyncIntegrationGroupProcedure
            if let integration = proc.output.value?.value {
                if integration.shouldRetrieveIssues {
                    let syncIssues = SyncIntegrationIssuesProcedure(source: source, destination: destination, integration: integration)
                    queue.addOperation(syncIssues)
                }
                if integration.shouldRetrieveCommits {
                    let syncCommits = SyncIntegrationCommitsProcedure(source: source, destination: destination, integration: integration)
                    queue.addOperation(syncCommits)
                }
            }
        default:
            break
        }
        
        if queue.operationCount == 0 {
            finish()
        }
    }
}
