import Dispatch

public protocol BotQueryable {
    func getBots(queue: DispatchQueue, completion: @escaping BotsResultHandler)
    func getBot(_ id: Bot.ID, queue: DispatchQueue, completion: @escaping BotResultHandler)
    func getStatsForBot(_ id: Bot.ID, queue: DispatchQueue, completion: @escaping BotStatsResultHandler)
}

public extension BotQueryable {
    func getBots(completion: @escaping BotsResultHandler) {
        getBots(queue: .main, completion: completion)
    }
    
    func getBot(_ id: Bot.ID, completion: @escaping BotResultHandler) {
        getBot(id, queue: .main, completion: completion)
    }
    
    func getStatsForBot(_ id: Bot.ID, completion: @escaping BotStatsResultHandler) {
        getStatsForBot(id, queue: .main, completion: completion)
    }
}
