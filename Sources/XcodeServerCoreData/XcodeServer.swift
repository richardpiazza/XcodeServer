import Foundation
import CoreData

/// An `XcodeServer` is one of the root elements in the object graph.
/// This represents a single Xcode Server, uniquely identified by its
/// FQDN (Fully Qualified Domain Name).
public class XcodeServer: NSManagedObject {
    
    public convenience init?(managedObjectContext: NSManagedObjectContext, fqdn: String) {
        self.init(managedObjectContext: managedObjectContext)
        self.fqdn = fqdn
    }
    
    /// The root API URL for this `XcodeServer`.
    /// Apple by default requires the HTTPS scheme and port 20343.
    public var apiURL: URL? {
        return URL(string: "https://\(self.fqdn):20343/api")
    }
}
