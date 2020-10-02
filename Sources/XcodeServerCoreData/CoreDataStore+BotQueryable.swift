import XcodeServer
import Dispatch

#if canImport(CoreData)
import CoreData

extension CoreDataStore: BotQueryable {
    public func getBots(queue: DispatchQueue, completion: @escaping BotsResultHandler) {
        dispatchQueue.async {
            let bots = self.persistentContainer.viewContext.bots()
            let result = bots.map { XcodeServer.Bot($0) }
            queue.async {
                completion(.success(result))
            }
        }
    }
    
    public func getBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue, completion: @escaping BotResultHandler) {
        dispatchQueue.async {
            if let bot = self.persistentContainer.viewContext.bot(withIdentifier: id) {
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
    
    public func getStatsForBot(_ id: XcodeServer.Bot.ID, queue: DispatchQueue, completion: @escaping BotStatsResultHandler) {
        dispatchQueue.async {
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