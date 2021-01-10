import XcodeServer
import ProcedureKit

public class GetBotsProcedure: Procedure, OutputProcedure {
    
    private let source: BotQueryable
    private let serverId: Server.ID?
    
    public var output: Pending<ProcedureResult<[Bot]>> = .pending
    
    public init(source: BotQueryable, serverId: Server.ID? = nil) {
        self.source = source
        self.serverId = serverId
        super.init()
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        switch serverId {
        case .none:
            source.getBots { [weak self] (result) in
                switch result {
                case .success(let value):
                    self?.output = .ready(.success(value))
                    self?.finish()
                case .failure(let error):
                    InternalLog.operations.error("GetBotsProcedure Failed", error: error)
                    self?.output = .ready(.failure(error))
                    self?.finish(with: error)
                }
            }
        case .some(let id):
            source.getBots(forServer: id) { [weak self] (result) in
                switch result {
                case .success(let value):
                    self?.output = .ready(.success(value))
                    self?.finish()
                case .failure(let error):
                    InternalLog.operations.error("GetBotsProcedure Failed", error: error)
                    self?.output = .ready(.failure(error))
                    self?.finish(with: error)
                }
            }
        }
    }
}
