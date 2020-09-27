import XcodeServer

public enum Activity: CustomStringConvertible {
    case createServer(id: Server.ID)
    
    public var description: String {
        switch self {
        case .createServer(let id):
            return "Creating Server with ID '\(id)'"
        }
    }
    
    static func log(_ activity: Activity) {
        
    }
}
