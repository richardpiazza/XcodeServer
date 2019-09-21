import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

public class CreateServerProcedure: NSPersistentContainerProcedure, InputProcedure, OutputProcedure {
    
    public typealias Input = String
    public typealias Output = [XcodeServerProcedureEvent]
    
    public var input: Pending<Input> = .pending
    public var output: Pending<ProcedureResult<Output>> = .pending
    
    public init(container: NSPersistentContainer, input: Input? = nil) {
        super.init(container: container)
        
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
        
        guard container.viewContext.server(withFQDN: value) == nil else {
            finish()
            return
        }
        
        print("Creating Server '\(value)'")
        
        container.performBackgroundTask({ [weak self] (context) in
            guard let _ = Server(managedObjectContext: context, fqdn: value) else {
                self?.finish(with: XcodeServerProcedureError.failedToCreateXcodeServer(fqdn: value))
                return
            }
            
            let events: [XcodeServerProcedureEvent] = [.server(action: .create, fqdn: value)]
            
            do {
                try context.save()
                self?.output = .ready(.success(events))
                self?.finish()
            } catch {
                print(error)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        })
    }
}

#endif
