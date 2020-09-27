import XcodeServer
import ProcedureKit

open class AnyQueryableProcedure: Procedure {
    
    public let source: AnyQueryable
    
    public init(source: AnyQueryable) {
        self.source = source
        super.init()
    }
}
