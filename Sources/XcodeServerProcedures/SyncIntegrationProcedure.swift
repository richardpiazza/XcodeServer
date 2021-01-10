import XcodeServer
import ProcedureKit

/// Sync - _retrieve & update_ - a single `Integration`.
///
///
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncIntegrationProcedure: Procedure, OutputProcedure {
    
    public typealias Source = AnyQueryable
    public typealias Destination = (AnyQueryable & AnyPersistable)
    
    private let source: Source
    private let destination: Destination
    private let integration: Integration
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public var output: Pending<ProcedureResult<Integration>> = .pending
    private var getCount: Int = 0
    
    public init(source: Source, destination: Destination, integration: Integration) {
        self.source = source
        self.destination = destination
        self.integration = integration
        super.init()
        
        procedureQueue.delegate = self
        procedureQueue.maxConcurrentOperationCount = 1
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        let get = GetIntegrationProcedure(source: source, input: integration.id)
        let update = UpdateIntegrationProcedure(destination: destination)
        update.injectResult(from: get)
        
        procedureQueue.addOperations([get, update])
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
extension SyncIntegrationProcedure: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didAddProcedure procedure: Procedure, context: Any?) {
        InternalLog.operations.debug("Enqueued Procedure '\(procedure)'")
    }
    
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        switch procedure {
        case is UpdateIntegrationProcedure:
            let getOutput = GetIntegrationProcedure(source: destination, input: integration.id)
            queue.addOperation(getOutput)
        case is GetIntegrationProcedure:
            switch getCount {
            case 0:
                getCount += 1
                break
            case 1:
                getCount += 1
                let proc = procedure as! GetIntegrationProcedure
                output = proc.output
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
        default:
            break
        }
        
        if queue.operationCount == 0 {
            finish()
        }
    }
}
