import Foundation
import CoreData

public enum XcodeServerProcedureError: Swift.Error, LocalizedError {
    public enum UnassignedObjectType: String {
        case xcodeServer = "XcodeServer"
        case bot = "Bot"
        case integration = "Integration"
    }
    
    case invalidInput
    case existingXcodeServer(fqdn: String)
    case failedToCreateXcodeServer(fqdn: String)
    case invalidManagedObjectID(id: NSManagedObjectID)
    case unassignedObject(type: UnassignedObjectType)
    case invalidAPIResponse
    case managedObjectContext
    case xcodeServer
    case bot
    case repository
    
    public var errorDescription: String? {
        switch self {
        case .invalidInput:
            return "The procedure input was nil or invalid."
        case .existingXcodeServer(let fqdn):
            return "An Xcode Server with FQDN '\(fqdn)' already exists."
        case .failedToCreateXcodeServer(let fqdn):
            return "Failed to create an Xcode Server with FQDN '\(fqdn)'."
        case .invalidManagedObjectID(let id):
            return "Object with id '\(id)' not found in NSManagedObjectContext."
        case .unassignedObject(let type):
            return "Expected object of type '\(type.rawValue)' is not assigned."
        case .invalidAPIResponse:
            return "The API Responded with a object not in the expected format."
        case .managedObjectContext:
            return "The parameter entity has an invalid NSManagedObjectContext."
        case .xcodeServer:
            return "An Xcode Server could not be identified for the supplied parameter entity."
        case .bot:
            return "A Bot could not be identified for the supplied parameter entity."
        case .repository:
            return "A Repository could not be identified for the supplied parameter entity."
        }
    }
}