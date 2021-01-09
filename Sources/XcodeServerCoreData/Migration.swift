import Foundation
#if canImport(CoreData)
import CoreData

enum Migration {
    
    enum Error: Swift.Error {
        case resource(name: String)
        case load(url: URL)
        case unidentifiedSource
        case noMigrationPath
        case mapping(source: Model, destination: Model)
    }
    
    struct Step: Hashable {
        let source: Model
        let destination: Model
        let mapping: NSMappingModel
    }
    
    /// Runs a multi-step '_progressive_' migration.
    ///
    /// - returns The initial `Model` version that was replaced.
    @discardableResult
    static func migrateStore(
        at storeURL: URL,
        to destination: Model,
        assistant: ModelAssistant
    ) throws -> Model? {
        guard FileManager.default.fileExists(atPath: storeURL.path) else {
            // No store exists at the path
            return nil
        }
        
        let destinationModel: NSManagedObjectModel = assistant.managedObjectModelFor(destination)
        
        let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: storeURL, options: nil)
        if destinationModel.isConfiguration(withName: .configurationName, compatibleWithStoreMetadata: metadata) {
            // The store is already consistent with the model version
            return nil
        }
        
        guard let source = assistant.modelCompatibleWith(metadata) else {
            throw Error.unidentifiedSource
        }
        
        guard migrationPathExists(from: source, to: destination) else {
            throw Error.noMigrationPath
        }
        
        let sourceModel: NSManagedObjectModel = assistant.managedObjectModelFor(source)
        try checkpoint(storeAtURL: storeURL, model: sourceModel)
        
        let tempURL: URL = .temporaryStoreURL
        let storeType = NSSQLiteStoreType
        
        let steps = try migrationSteps(from: source, to: destination, assistant: assistant)
        for step in steps {
            let source: NSManagedObjectModel = assistant.managedObjectModelFor(step.source)
            let destination: NSManagedObjectModel = assistant.managedObjectModelFor(step.destination)
            let manager = NSMigrationManager(sourceModel: source, destinationModel: destination)
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: .init())
            try manager.migrateStore(from: storeURL, sourceType: storeType, options: nil, with: step.mapping, toDestinationURL: tempURL, destinationType: storeType, destinationOptions: nil)
            try coordinator.destroyPersistentStore(at: storeURL, ofType: storeType, options: nil)
            try coordinator.replacePersistentStore(at: storeURL, destinationOptions: nil, withPersistentStoreFrom: tempURL, sourceOptions: nil, ofType: storeType)
            try FileManager.default.removeItem(at: tempURL)
        }
        
        return source
    }
    
    static func migrationPathExists(from: Model, to: Model) -> Bool {
        guard let sourceIndex = Model.allCases.firstIndex(of: from) else {
            return false
        }
        
        guard let destinationIndex = Model.allCases.firstIndex(of: to) else {
            return false
        }
        
        return sourceIndex < destinationIndex
    }
    
    static func checkpoint(storeAtURL url: URL, model: NSManagedObjectModel) throws {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let options = [NSSQLitePragmasOption: ["journal_mode": "DELETE"]]
        let store = try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: .configurationName, at: url, options: options)
        try coordinator.remove(store)
    }
    
    static func migrationSteps(from: Model, to: Model, assistant: ModelAssistant) throws -> [Step] {
        var steps: [Step] = []
        
        var current: Model = from
        while let next = current.nextVersion {
            guard let mapping = assistant.mappingModelTo(next) else {
                throw Error.mapping(source: current, destination: next)
            }
            
            steps.append(Step(source: current, destination: next, mapping: mapping))
            
            guard next != to else {
                return steps
            }
            
            current = next
        }
        
        return steps
    }
}
#endif
