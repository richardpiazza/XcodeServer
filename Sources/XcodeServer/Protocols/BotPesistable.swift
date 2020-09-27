import Dispatch

public protocol BotPersistable {
    func saveBot(_ bot: Bot, queue: DispatchQueue, completion: @escaping BotResultHandler)
    func deleteBot(_ bot: Bot, queue: DispatchQueue, completion: @escaping VoidResultHandler)
}

// MARK: - Default Parameters
public extension BotPersistable {
    func saveBot(_ bot: Bot, completion: @escaping BotResultHandler) {
        saveBot(bot, queue: .main, completion: completion)
    }
    
    func deleteBot(_ bot: Bot, completion: @escaping VoidResultHandler) {
        deleteBot(bot, queue: .main, completion: completion)
    }
}
