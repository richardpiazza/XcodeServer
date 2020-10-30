import XcodeServer
import Foundation

public enum XcodeServerProcedureError: Swift.Error, LocalizedError {
    public enum UnassignedObjectType: String {
        case xcodeServer = "XcodeServer"
        case bot = "Bot"
        case integration = "Integration"
    }
    
    case invalidInput
    case existingXcodeServer(id: Server.ID)
    case failedToCreateXcodeServer(id: Server.ID)
    case failedToCreateIntegration(id: Integration.ID)
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
        case .existingXcodeServer(let value):
            return "An Xcode Server with FQDN '\(value)' already exists."
        case .failedToCreateXcodeServer(let value):
            return "Failed to create an Xcode Server with FQDN '\(value)'."
        case .failedToCreateIntegration(let id):
            return "Failed to create an Integration with ID '\(id)'."
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
