import Dispatch
import XcodeServer

extension XCSClient: BotQueryable {
    public func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        InternalLog.api.info("Retrieving ALL Bots")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.bots { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let bots):
                    let results = bots.map { Bot($0, server: self.fqdn) }
                    queue.async {
                        completion(.success(results))
                    }
                }
            }
        }
    }
    
    public func getBots(forServer id: Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        InternalLog.api.info("Retrieving BOTS for Server [\(id)]")
        let queue = queue ?? returnQueue
        guard self.fqdn == id else {
            queue.async {
                completion(.failure(.message("Invalid Server")))
            }
            return
        }
        
        internalQueue.async {
            self.bots { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let bots):
                    let results = bots.map { Bot($0, server: self.fqdn) }
                    queue.async {
                        completion(.success(results))
                    }
                }
            }
        }
    }
    
    public func getBot(_ id: Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        InternalLog.api.info("Retrieving Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.bot(withIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let bot):
                    let value = Bot(bot, server: nil)
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getStatsForBot(_ id: Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        InternalLog.api.info("Retrieving STATS for Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.stats(forBotWithIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let stats):
                    let value = Bot.Stats(stats)
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
}
