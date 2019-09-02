import Foundation
import CoreData
import ProcedureKit
import XcodeServerAPI
import XcodeServerCoreData

open class NSPersistentContainerProcedure: Procedure, InputProcedure {
    
    public typealias Input = NSManagedObject
    
    open var input: Pending<Input> = .pending
    open var container: NSPersistentContainer = .xcodeServerCoreData
    
    public init(input: Input? = nil) {
        super.init()
        if let value = input {
            self.input = .ready(value)
        }
    }
    
    open override func execute() {
        guard !isCancelled else {
            return
        }
        
        guard let _ = input.value else {
            finish(with: XcodeServerProcedureError.invalidInput)
            return
        }
        
        performTask()
    }
    
    open func performTask() {
        finish()
    }
}
