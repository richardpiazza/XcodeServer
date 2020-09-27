import XcodeServer
import ProcedureKit

open class AnyPersistableProcedure: Procedure {
    
    public let destination: AnyPersistable
    
    public init(destination: AnyPersistable) {
        self.destination = destination
        super.init()
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
open class IdentifiablePersitableProcedure<I: Swift.Identifiable>: AnyPersistableProcedure {
    
    public let identifiable: I
    public let id: I.ID
    
    public init(destination: AnyPersistable, identifiable: I) {
        self.identifiable = identifiable
        self.id = identifiable.id
        super.init(destination: destination)
    }
}

open class AnyPersistableGroupProcedure: GroupProcedure {
    
    public let destination: AnyPersistable
    
    public init(destination: AnyPersistable, operations: [Procedure]) {
        self.destination = destination
        super.init(operations: operations)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(swift, introduced: 5.1)
open class IdentifiablePersitableGroupProcedure<I: Swift.Identifiable>: AnyPersistableGroupProcedure {
    
    public let identifiable: I
    public let id: I.ID
    
    public init(destination: AnyPersistable, identifiable: I, operations: [Procedure]) {
        self.identifiable = identifiable
        self.id = identifiable.id
        super.init(destination: destination, operations: operations)
    }
}
