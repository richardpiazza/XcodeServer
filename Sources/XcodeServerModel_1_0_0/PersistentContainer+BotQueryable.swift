import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension PersistentContainer: BotQueryable {
    public func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let bots = Bot.bots(in: context)
                let result = bots.map { XcodeServer.Bot($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getBots(forServer id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let bots = Bot.bots(forServer: id, in: context)
                let result = bots.map { XcodeServer.Bot($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                if let bot = Bot.bot(id, in: context) {
                    let result = XcodeServer.Bot(bot)
                    queue.async {
                        completion(.success(result))
                    }
                } else {
                    queue.async {
                        completion(.failure(.noBot(id)))
                    }
                }
            }
        }
    }
    
    public func getStatsForBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let bot = Bot.bot(id, in: context) else {
                    queue.async {
                        completion(.failure(.noBot(id)))
                    }
                    return
                }
                
                guard let stats = bot.stats else {
                    queue.async {
                        completion(.failure(.noStatsForBot(id)))
                    }
                    return
                }
                
                let result = XcodeServer.Bot.Stats(stats)
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
}

#endif
