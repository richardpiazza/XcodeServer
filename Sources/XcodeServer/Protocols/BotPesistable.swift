import Dispatch

public protocol BotPersistable {
    func saveBot(_ bot: Bot, forServer server: Server.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler)
    func deleteBot(_ bot: Bot, queue: DispatchQueue?, completion: @escaping VoidResultHandler)
    
    func saveStats(_ stats: Bot.Stats, forBot bot: Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler)
}

// MARK: - Default Parameters
public extension BotPersistable {
    func saveBot(_ bot: Bot, forServer server: Server.ID, completion: @escaping BotResultHandler) {
        saveBot(bot, forServer: server, queue: nil, completion: completion)
    }
    
    func deleteBot(_ bot: Bot, completion: @escaping VoidResultHandler) {
        deleteBot(bot, queue: nil, completion: completion)
    }
    
    func saveStats(_ stats: Bot.Stats, forBot bot: Bot.ID, completion: @escaping BotStatsResultHandler) {
        saveStats(stats, forBot: bot, queue: nil, completion: completion)
    }
}
