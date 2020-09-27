import XcodeServer
import ProcedureKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncServerProcedure: IdentifiablePersitableProcedure<Server>, OutputProcedure {
    
    public var source: AnyQueryable
    public var output: Pending<ProcedureResult<[XcodeServerProcedureEvent]>> = .pending
    private var events: [XcodeServerProcedureEvent] = []
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public init(source: AnyQueryable, destination: AnyPersistable, identifiable: Server) {
        self.source = source
        super.init(destination: destination, identifiable: identifiable)
        procedureQueue.delegate = self
        procedureQueue.maxConcurrentOperationCount = 1
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        let version = SyncVersionProcedure(source: source, destination: destination, identifiable: identifiable)
        let bots = SyncServerBotsProcedure(source: source, destination: destination, identifiable: identifiable)
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
            if let events = sync.output.success {
                self.events.append(contentsOf: events)
            }
            sync.bots?.forEach({ (bot) in
                let stats = SyncBotStatsProcedure(source: source, destination: destination, identifiable: bot)
                let next = SyncBotIntegrationsProcedure(source: source, destination: destination, identifiable: bot)
                next.addDependency(stats)
                queue.addOperations([stats, next])
            })
        case is SyncBotIntegrationsProcedure:
            guard error == nil else {
                print(error!)
                break
            }
            
            let sync = procedure as! SyncBotIntegrationsProcedure
            if let events = sync.output.success {
                self.events.append(contentsOf: events)
            }
            sync.integrations?.forEach({ (integration) in
                let next = SyncIntegrationProcedure(source: source, destination: destination, identifiable: integration)
                queue.addOperation(next)
            })
        case is SyncIntegrationProcedure:
            guard error == nil else {
                print(error!)
                break
            }
            
            let sync = procedure as! SyncIntegrationProcedure
            if let events = sync.output.success {
                self.events.append(contentsOf: events)
            }
            
            let issues = SyncIntegrationIssuesProcedure(source: source, destination: destination, identifiable: sync.identifiable)
            let commits = SyncIntegrationCommitsProcedure(source: source, destination: destination, identifiable: sync.identifiable)

            queue.addOperations([issues, commits])
        default:
            break
        }
        
        if queue.operationCount == 0 {
            output = .ready(.success(events))
            finish()
        }
    }
}
