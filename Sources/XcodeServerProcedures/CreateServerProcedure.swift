import Foundation
import ProcedureKit
import XcodeServerAPI
#if canImport(CoreData)
import CoreData
import XcodeServerCoreData

/// Creates a `Server` entity in the the `ManagedObjectContext`.
///
/// This procedure will complete in one of four expected ways:
/// * _Failure_; An error reason will be provided
/// * _Cancelation_: Invalid input provided to complete the operation.
/// * _Success, with events_: The server was created successfully and a `.crete` event will be provided.
/// * _Success, no events_: The server already existed and no action was taken.
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
            let error = XcodeServerProcedureError.invalidInput
            cancel(with: error)
            output = .ready(.failure(error))
            finish(with: error)
            return
        }
        
        guard container.viewContext.server(withFQDN: value) == nil else {
            output = .ready(.success([]))
            finish()
            return
        }
        
        print("Creating Server '\(value)'")
        
        container.performBackgroundTask({ [weak self] (context) in
            guard let _ = Server(managedObjectContext: context, fqdn: value) else {
                let error = XcodeServerProcedureError.failedToCreateXcodeServer(fqdn: value)
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
                return
            }
            
            let events: [XcodeServerProcedureEvent] = [.server(action: .create, fqdn: value)]
            
            do {
                try context.save()
                self?.output = .ready(.success(events))
                self?.finish()
            } catch {
                self?.output = .ready(.failure(error))
                self?.finish(with: error)
            }
        })
    }
}

#endif
