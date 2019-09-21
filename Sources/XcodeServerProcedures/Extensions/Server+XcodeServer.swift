import Foundation
import XcodeServerAPI
#if canImport(CoreData)
import XcodeServerCoreData

public extension Server {
    func update(withVersion version: XCSVersion, api: Int? = nil) {
        self.os = version.os
        self.server = version.server
        self.xcodeServer = version.xcodeServer
        self.xcode = version.xcode
        if let api = api {
            self.apiVersion = Int32(api)
        }
    }
    
    @discardableResult
    func update(withBots data: [XCSBot]) -> [XcodeServerProcedureEvent] {
        var events: [XcodeServerProcedureEvent] = []
        
        guard let moc = self.managedObjectContext else {
            return events
        }
        
        guard let bots = self.bots else {
            return events
        }
        
        var ids: [String] = bots.compactMap({ $0.identifier })
        
        for element in data {
            if let index = ids.firstIndex(of: element.identifier) {
                ids.remove(at: index)
            }
            
            if let bot = moc.bot(withIdentifier: element.identifier) {
                let botEvents = bot.update(withBot: element)
                events.append(contentsOf: botEvents)
                continue
            }
            
            if let bot = Bot(managedObjectContext: moc, identifier: element.identifier, server: self) {
                events.append(.bot(action: .create, identifier: element.identifier, name: element.name))
                let botEvents = bot.update(withBot: element)
                events.append(contentsOf: botEvents)
            }
        }
        
        for id in ids {
            if let bot = moc.bot(withIdentifier: id) {
                events.append(.bot(action: .delete, identifier: bot.identifier, name: bot.name ?? ""))
                bot.server = nil
                moc.delete(bot)
            }
        }
        
        return events
    }
}

#endif
