import XcodeServer
#if canImport(CoreData)
import CoreData

public extension Filter {
    func update(_ filter: XcodeServer.Device.Filter, context: NSManagedObjectContext) {
        if platform == nil {
            platform = Platform(context: context)
        }
        
        filterTypeRawValue = Int16(filter.type)
        architectureTypeRawValue = Int16(filter.architecture)
        platform?.update(filter.platform, context: context)
    }
}

internal func == (lhs: Filter, rhs: XcodeServer.Device.Filter) -> Bool {
    guard Int(lhs.architectureTypeRawValue) == rhs.architecture else {
        return false
    }
    guard Int(lhs.filterTypeRawValue) == rhs.type else {
        return false
    }
    guard let p = lhs.platform, p == rhs.platform else {
        return false
    }
    return true
}
#endif
