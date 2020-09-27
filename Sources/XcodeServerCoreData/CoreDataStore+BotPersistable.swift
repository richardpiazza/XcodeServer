import XcodeServer
import Dispatch
#if canImport(CoreData)
import CoreData

extension CoreDataStore: BotPersistable {
    public func saveBot(_ bot: XcodeServer.Bot, queue: DispatchQueue, completion: @escaping BotResultHandler) {
        dispatchQueue.async {
            self.persistentContainer.performBackgroundTask { (context) in
                let _bot = context.bot(withIdentifier: bot.id) ?? XcodeServerCoreData.Bot(context: context)
                _bot.update(bot, context: context)
                
                do {
                    try context.save()
                    let result = XcodeServer.Bot(_bot)
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
    
    public func deleteBot(_ bot: XcodeServer.Bot, queue: DispatchQueue, completion: @escaping VoidResultHandler) {
        dispatchQueue.async {
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
