import XcodeServer
import Dispatch

#if canImport(CoreData)
import CoreData

extension CoreDataStore: BotQueryable {
    public func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        InternalLog.coreData.debug("Retrieving ALL Bots")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let bots = context.bots()
                let result = bots.map { XcodeServer.Bot($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getBots(forServer id: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        InternalLog.coreData.debug("Retrieving ALL Bots for Server [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let bots = context.bots(forServer: id)
                let result = bots.map { XcodeServer.Bot($0) }
                queue.async {
                    completion(.success(result))
                }
            }
        }
    }
    
    public func getBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        InternalLog.coreData.debug("Retrieving Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                if let bot = context.bot(withIdentifier: id) {
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
        InternalLog.coreData.debug("Retrieving STATS for Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let bot = context.bot(withIdentifier: id) else {
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
