import Foundation
import XcodeServerAPI
import XcodeServerCoreData

extension Filter {
    public func update(withFilter filter: XCSFilter) {
        guard let moc = self.managedObjectContext else {
            return
        }
        
        self.filterType = filter.filterType as NSNumber?
        self.architectureType = filter.architectureType as NSNumber?
        
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
