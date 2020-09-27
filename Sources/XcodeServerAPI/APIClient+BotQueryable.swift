import Dispatch
import XcodeServer

extension APIClient: BotQueryable {
    public func getBots(queue: DispatchQueue, completion: @escaping BotsResultHandler) {
        dispatchQueue.async {
            self.bots { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let bots):
                    let results = bots.map { Bot($0) }
                    queue.async {
                        completion(.success(results))
                    }
                }
            }
        }
    }
    
    public func getBot(_ id: Bot.ID, queue: DispatchQueue, completion: @escaping BotResultHandler) {
        dispatchQueue.async {
            self.bot(withIdentifier: id) { (result) in
                switch result {
                case .failure(let error):
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                case .success(let bot):
                    let value = Bot(bot)
                    queue.async {
                        completion(.success(value))
                    }
                }
            }
        }
    }
    
    public func getStatsForBot(_ id: Bot.ID, queue: DispatchQueue, completion: @escaping BotStatsResultHandler) {
        dispatchQueue.async {
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
