import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Filter {
    public func update(withFilter filter: XCSFilter) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.filterTypeRawValue = Int16(filter.filterType ?? 0)
        self.architectureTypeRawValue = Int16(filter.architectureType ?? 0)
        
        if let filterPlatform = filter.platform {
            if self.platform == nil {
                self.platform = Platform(managedObjectContext: moc, filter: self)
            }
            
            if let platform = self.platform {
                platform.update(withPlatform: filterPlatform)
            }
        }
    }
}
