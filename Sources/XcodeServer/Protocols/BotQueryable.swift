import Dispatch

public protocol BotQueryable {
    func getBots(queue: DispatchQueue?, completion: @escaping BotsResultHandler)
    func getBots(forServer id: Server.ID, queue: DispatchQueue?, completion: @escaping BotsResultHandler)
    func getBot(_ id: Bot.ID, queue: DispatchQueue?, completion: @escaping BotResultHandler)
    func getStatsForBot(_ id: Bot.ID, queue: DispatchQueue?, completion: @escaping BotStatsResultHandler)
}

public extension BotQueryable {
    func getBots(completion: @escaping BotsResultHandler) {
        getBots(queue: nil, completion: completion)
    }
    
    func getBots(forServer id: Server.ID, completion: @escaping BotsResultHandler) {
        getBots(forServer: id, queue: nil, completion: completion)
    }
    
    func getBot(_ id: Bot.ID, completion: @escaping BotResultHandler) {
        getBot(id, queue: nil, completion: completion)
    }
    
    func getStatsForBot(_ id: Bot.ID, completion: @escaping BotStatsResultHandler) {
        getStatsForBot(id, queue: nil, completion: completion)
    }
}
