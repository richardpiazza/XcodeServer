import XcodeServer
import ProcedureKit

/// Sync - _retrieve & update_ - a single `Server`.
///
/// For each `Bot` that available on the server, a `SyncBotProcedure` will be added to the procedure queue.
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncServerProcedure: Procedure, OutputProcedure {
    
    public typealias Source = AnyQueryable
    public typealias Destination = (AnyQueryable & AnyPersistable)
    
    private let source: Source
    private let destination: Destination
    private let server: Server
    private let syncBots: Bool
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public var output: Pending<ProcedureResult<Server>> = .pending
    private var getCount: Int = 0
    
    /// Initializes a `SyncServerProcedure`.
    ///
    /// - parameter source: The `AnyQueryable` source for the initial bot query.
    /// - parameter destination: The `AnyQueryable & AnyPersistable` storage.
    /// - parameter server: The `Server` that requires syncing.
    /// - parameter syncBots: Indicates if further bot processing should be executed.
    public init(source: Source, destination: Destination, server: Server, syncBots: Bool = true) {
        self.source = source
        self.destination = destination
        self.server = server
        self.syncBots = syncBots
        super.init()
        
        procedureQueue.delegate = self
        procedureQueue.maxConcurrentOperationCount = 1
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        let versions = SyncVersionProcedure(source: source, destination: destination, server: server)
        let get = GetBotsProcedure(source: source)
        get.addDependency(versions)
        let update = UpdateServerBotsProcedure(destination: destination, server: server)
        update.injectResult(from: get)
        
        procedureQueue.addOperations([versions, get, update])
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
extension SyncServerProcedure: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didAddProcedure procedure: Procedure, context: Any?) {
        InternalLog.operations.debug("Enqueued Procedure '\(procedure)'")
    }
    
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        switch procedure {
        case is UpdateServerBotsProcedure:
            let getOutput = GetBotsProcedure(source: destination, serverId: server.id)
            queue.addOperation(getOutput)
        case is GetBotsProcedure:
            switch getCount {
            case 0:
                getCount += 1
                break
            case 1:
                getCount += 1
                let proc = procedure as! GetBotsProcedure
                switch proc.output.value {
                case .none:
                    break
                case .failure(let e):
                    output = .ready(.failure(e))
                case .success(let bots):
                    var s = server
                    s.bots = Set(bots)
                    output = .ready(.success(s))
                    
                    if syncBots {
                        bots.forEach({
                            let sync = SyncBotProcedure(source: source, destination: destination, bot: $0)
                            queue.addOperation(sync)
                        })
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
