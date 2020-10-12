import XcodeServer
import Dispatch

#if canImport(CoreData)
import CoreData

extension CoreDataStore: BotQueryable {
    public func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler) {
        InternalLog.coreData.info("Retrieving ALL Bots")
        let queue = queue ?? returnQueue
        internalQueue.async {
            let bots = self.persistentContainer.viewContext.bots()
            let result = bots.map { XcodeServer.Bot($0) }
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    public func getBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        InternalLog.coreData.info("Retrieving Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            if let bot = self.persistentContainer.viewContext.bot(withIdentifier: id) {
                let result = XcodeServer.Bot(bot, depth: 1)
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
    
    public func getStatsForBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        InternalLog.coreData.info("Retrieving STATS for Bot [\(id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            guard let bot = self.persistentContainer.viewContext.bot(withIdentifier: id) else {
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

#endif
