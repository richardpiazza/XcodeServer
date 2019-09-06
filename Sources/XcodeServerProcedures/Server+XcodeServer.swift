import Foundation
import XcodeServerAPI
import XcodeServerCoreData

public extension Server {
    func update(withVersion version: XCSVersion, api: Int? = nil) {
        self.os = version.os
        self.server = version.server
        self.xcodeServer = version.xcodeServer
        self.xcode = version.xcode
        if let api = api {
            self.apiVersion = api as NSNumber
        }
    }
    
    func update(withBots data: [XCSBot]) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        guard let bots = self.bots else {
            return
        }
        
        var ids: [String] = bots.map({ $0.identifier })
        
        for element in data {
            if let index = ids.firstIndex(of: element.identifier) {
                ids.remove(at: index)
            }
            
            if let bot = moc.bot(withIdentifier: element.identifier) {
                bot.update(withBot: element)
                continue
            }
            
            if let bot = Bot(managedObjectContext: moc, identifier: element.identifier, server: self) {
                bot.update(withBot: element)
            }
        }
        
        for id in ids {
            if let bot = moc.bot(withIdentifier: id) {
                bot.server = nil
                moc.delete(bot)
            }
        }
    }
}
