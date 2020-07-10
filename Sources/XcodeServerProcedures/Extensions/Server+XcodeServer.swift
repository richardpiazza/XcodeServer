import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

public extension Server {
    func update(withVersion version: XCSVersion, api: Int? = nil) {
        self.os = version.macOSVersion
        self.server = version.serverAppVersion
        self.xcodeServer = version.xcodeServerVersion
        self.xcode = version.xcodeAppVersion
        if let api = api {
            self.apiVersion = Int32(api)
        }
    }
    
    @discardableResult
    func update(withBots data: [XCSBot]) -> [XcodeServerProcedureEvent] {
        var events: [XcodeServerProcedureEvent] = []
        
        guard let context = self.managedObjectContext else {
            return events
        }
        
        guard let bots = self.bots else {
            return events
        }
        
        var ids: [String] = bots.compactMap({ $0.identifier })
        
        for element in data {
            if let index = ids.firstIndex(of: element.id) {
                ids.remove(at: index)
            }
            
            if let bot = context.bot(withIdentifier: element.id) {
                let botEvents = bot.update(withBot: element)
                events.append(contentsOf: botEvents)
                continue
            }
            
            if let bot = Bot(managedObjectContext: context, identifier: element.id, server: self) {
                events.append(.bot(action: .create, identifier: element.id, name: element.name))
                let botEvents = bot.update(withBot: element)
                events.append(contentsOf: botEvents)
            }
        }
        
        for id in ids {
            if let bot = context.bot(withIdentifier: id) {
                events.append(.bot(action: .delete, identifier: bot.identifier, name: bot.name ?? ""))
                bot.server = nil
                context.delete(bot)
            }
        }
        
        return events
    }
}

#endif
