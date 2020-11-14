import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: BotPersistable {
    public func saveBot(_ bot: XcodeServer.Bot, forServer server: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        InternalLog.coreData.info("Saving Bot '\(bot.name)' [\(bot.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _bot: XcodeServerCoreData.Bot
                
                if let existing = context.bot(withIdentifier: bot.id) {
                    _bot = existing
                } else {
                    guard let _server = context.server(withFQDN: server) else {
                        queue.async {
                            completion(.failure(.noServer(server)))
                        }
                        return
                    }
                    
                    _bot = context.make()
                    _bot.server = _server
                }
                
                _bot.lastUpdate = Date()
                _bot.update(bot, context: context)
                
                let result = XcodeServer.Bot(_bot)
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(result))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
    
    public func saveStats(_ stats: XcodeServer.Bot.Stats, forBot bot: XcodeServer.Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler) {
        InternalLog.coreData.info("Saving STATS for Bot [\(bot)]")
        let queue = queue ?? returnQueue
        self.persistentContainer.performBackgroundTask { (context) in
            guard let _bot = context.bot(withIdentifier: bot) else {
                queue.async {
                    completion(.failure(.noBot(bot)))
                }
                return
            }
            
            if _bot.stats == nil {
                _bot.stats = context.make()
            }
            
            _bot.stats?.update(stats, context: context)
            
            let result = XcodeServer.Bot.Stats(_bot.stats!)
            
            do {
                try context.save()
                queue.async {
                    completion(.success(result))
                }
            } catch {
                queue.async {
                    completion(.failure(.error(error)))
                }
            }
        }
    }
    
    public func deleteBot(_ bot: XcodeServer.Bot, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        InternalLog.coreData.info("Removing Bot '\(bot.name)' [\(bot.id)]")
        let queue = queue ?? returnQueue
        internalQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                guard let _bot = context.bot(withIdentifier: bot.id) else {
                    queue.async {
                        completion(.failure(.noBot(bot.id)))
                    }
                    return
                }
                
                context.delete(_bot)
                
                do {
                    try context.save()
                    queue.async {
                        completion(.success(()))
                    }
                } catch {
                    queue.async {
                        completion(.failure(.error(error)))
                    }
                }
            }
        }
    }
}

#endif
