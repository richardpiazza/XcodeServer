import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension PersistentContainer: BotPersistable {
    public func saveBot(_ bot: XcodeServer.Bot, forServer server: XcodeServer.Server.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler) {
        InternalLog.persistence.info("Saving Bot '\(bot.name)' [\(bot.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                let _bot: Bot
                
                if let existing = Bot.bot(bot.id, in: context) {
                    _bot = existing
                } else {
                    guard let _server = Server.server(server, in: context) else {
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
        InternalLog.persistence.info("Saving STATS for Bot [\(bot)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let _bot = Bot.bot(bot, in: context) else {
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
    }
    
    public func deleteBot(_ bot: XcodeServer.Bot, queue: DispatchQueue?, completion: @escaping VoidResultHandler) {
        InternalLog.persistence.info("Removing Bot '\(bot.name)' [\(bot.id)]")
        let queue = queue ?? dispatchQueue
        internalQueue.async {
            self.performBackgroundTask { (context) in
                guard let _bot = Bot.bot(bot.id, in: context) else {
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
