import CoreDataPlus
#if canImport(CoreData)

public extension Persistence {
    static let xcodeServer: Persistence = .store(.xcodeServer)
}

public extension StoreURL {
    static var xcodeServer: StoreURL {
        guard let url = try? StoreURL(applicationSupport: .configurationName, folder: .containerName) else {
            preconditionFailure("Unable to load StoreURL for 'default' Persistence.")
        }
        
        return url
    }
}

#endif
