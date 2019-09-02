import Foundation
import CoreData
import ProcedureKit
import XcodeServerAPI
import XcodeServerCoreData

public class UpdateVersionProcedure: Procedure, InputProcedure {
    
    public typealias Input = (version: XCSVersion, api: Int?)
    
    public var input: Pending<Input> = .pending
    
    private var server: Server
    private var container: NSPersistentContainer = .xcodeServerCoreData
    
    public init(server: Server, input: Input? = nil) {
        self.server = server
        
        super.init()
        
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    public override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let value = input.value else {
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        let objectId = server.objectID
        
        container.performBackgroundTask { [weak self] (context) in
            guard let object = context.object(with: objectId) as? Server else {
                self?.finish(with: XcodeServerProcedureError.invalidManagedObjectID(id: objectId))
                return
            }
            
            object.os = value.version.os
            object.server = value.version.server
            object.xcodeServer = value.version.xcodeServer
            object.xcode = value.version.xcode
            if let api = value.api {
                object.apiVersion = api as NSNumber
            }
            
            do {
                try context.save()
                self?.finish()
            } catch {
                self?.finish(with: error)
            }
        }
    }
    
}
