import XCTest
@testable import XcodeServer
@testable import XcodeServerCoreData

#if canImport(CoreData)
extension CoreDataStore {
    var exampleServer: XcodeServerCoreData.Server? {
        let request = XcodeServerCoreData.Server.fetchRequest() as! NSFetchRequest<XcodeServerCoreData.Server>
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(XcodeServerCoreData.Server.fqdn), XcodeServer.Server.ID.example)
        return try? persistentContainer.viewContext.fetch(request).first
    }
    
    var dynumiteBot: XcodeServerCoreData.Bot? {
        let request = XcodeServerCoreData.Bot.fetchRequest() as! NSFetchRequest<XcodeServerCoreData.Bot>
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(XcodeServerCoreData.Bot.identifier), XcodeServer.Bot.ID.dynumiteMacOS)
        return try? persistentContainer.viewContext.fetch(request).first
    }
    
    var dynumiteIntegration: XcodeServerCoreData.Integration? {
        let request = XcodeServerCoreData.Integration.fetchRequest() as! NSFetchRequest<XcodeServerCoreData.Integration>
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(XcodeServerCoreData.Integration.identifier), XcodeServer.Integration.ID.dynumiteUnknown)
        return try? persistentContainer.viewContext.fetch(request).first
    }
}
#endif
