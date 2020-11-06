import XcodeServer
import ProcedureKit

/// Sync - _retrieve & update_ - a single `Bot`.
///
/// For each `Integration` that available on the bot, a `SyncIntegrationProcedure` will be added to the procedure queue.
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
public class SyncBotProcedure: Procedure, OutputProcedure {
    
    public typealias Source = AnyQueryable
    public typealias Destination = (AnyQueryable & AnyPersistable)
    
    private let source: Source
    private let destination: Destination
    private let bot: Bot
    private let syncIntegrations: Bool
    private let procedureQueue: ProcedureQueue = ProcedureQueue()
    
    public var output: Pending<ProcedureResult<Bot>> = .pending
    private var getCount: Int = 0
    
    /// Initializes a `SyncBotProcedure`.
    ///
    /// - parameter source: The `AnyQueryable` source for the initial integrations query.
    /// - parameter destination: The `AnyQueryable & AnyPersistable` storage.
    /// - parameter server: The `Bot` that requires syncing.
    /// - parameter syncIntegrations: Indicates if further integration processing should be executed.
    public init(source: Source, destination: Destination, bot: Bot, syncIntegrations: Bool = true) {
        self.source = source
        self.destination = destination
        self.bot = bot
        self.syncIntegrations = syncIntegrations
        super.init()
        
        procedureQueue.delegate = self
        procedureQueue.maxConcurrentOperationCount = 1
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        let stats = SyncBotStatsProcedure(source: source, destination: destination, bot: bot)
        let get = GetBotIntegrationsProcedure(source: source, input: bot.id)
        get.addDependency(stats)
        let update = UpdateBotIntegrationsProcedure(destination: destination, bot: bot)
        update.injectResult(from: get)
        
        procedureQueue.addOperations([stats, get, update])
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
extension SyncBotProcedure: ProcedureQueueDelegate {
    public func procedureQueue(_ queue: ProcedureQueue, didAddProcedure procedure: Procedure, context: Any?) {
        InternalLog.procedures.debug("Enqueued Procedure '\(procedure)'")
    }
    
    public func procedureQueue(_ queue: ProcedureQueue, didFinishProcedure procedure: Procedure, with error: Error?) {
        switch procedure {
        case is UpdateBotIntegrationsProcedure:
            let getOutput = GetBotIntegrationsProcedure(source: destination, input: bot.id)
            queue.addOperation(getOutput)
        case is GetBotIntegrationsProcedure:
            switch getCount {
            case 0:
                getCount += 1
                break
            case 1:
                getCount += 1
                let proc = procedure as! GetBotIntegrationsProcedure
                switch proc.output.value {
                case .none:
                    break
                case .failure(let e):
                    output = .ready(.failure(e))
                case .success(let integrations):
                    var b = bot
                    b.integrations = Set(integrations)
                    output = .ready(.success(b))
                    
                    if syncIntegrations {
                        integrations.forEach({
                            let sync = SyncIntegrationProcedure(source: source, destination: destination, integration: $0)
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
