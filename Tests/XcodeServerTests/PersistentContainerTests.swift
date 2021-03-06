import XCTest
@testable import XcodeServer
@testable import XcodeServerCoreData
import CoreDataPlus
#if canImport(CoreData)
import CoreData

final class PersistentContainerTests: XCTestCase {
    
    static var allTests = [
        ("testModel_1_0_0_Initialization", testModel_1_0_0_Initialization),
        ("testEmptyStore_Model_1_0_0_Metadata", testEmptyStore_Model_1_0_0_Metadata),
        ("testFullStore_Model_1_0_0_Metadata", testFullStore_Model_1_0_0_Metadata),
        ("testMigrateToCurrentStore", testMigrateToCurrentStore),
    ]
    
    func testModel_1_0_0_Initialization() {
        #if swift(>=5.3)
        let exp = expectation(description: "\(#function)")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.url = nil
        description.shouldInferMappingModelAutomatically = false
        description.shouldMigrateStoreAutomatically = false
        
        let model = Model.v1_0_0.managedObjectModel
        
        let container = NSPersistentContainer.init(name: .containerName, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                XCTFail()
                return
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        #endif
    }
    
    func testEmptyStore_Model_1_0_0_Metadata() throws {
        #if swift(>=5.3)
        let model = Model.v1_0_0.managedObjectModel
        let url = try XCTUnwrap(Bundle.module.url(forResource: .model_1_0_0_empty, withExtension: .sqlite))
        let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: url, options: nil)
        XCTAssertTrue(model.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata))
        #endif
    }
    
    func testFullStore_Model_1_0_0_Metadata() throws {
        #if swift(>=5.3)
        let model = Model.v1_0_0.managedObjectModel
        let url = try XCTUnwrap(Bundle.module.url(forResource: .model_1_0_0_populated, withExtension: .sqlite))
        let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: url, options: nil)
        XCTAssertTrue(model.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata))
        #endif
    }
    
    func testMigrateToCurrentStore() throws {
        #if swift(>=5.3)
        try FileManager.default.overwriteDefaultStore(withResource: .model_1_0_0_populated)
        let storeURL = StoreURL.xcodeServer
        let storeModel = Model.v1_0_0.managedObjectModel
        var metadata: [String: Any] = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: storeURL.storeType, at: storeURL.rawValue, options: nil)
        XCTAssertTrue(storeModel.isConfiguration(withName: .configurationName, compatibleWithStoreMetadata: metadata))
        
        let model = Model.current
        let objectModel: NSManagedObjectModel = model.managedObjectModel
        let _ = try CoreDataStore(model: model, persistence: .xcodeServer, silentFailure: false)
        metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: storeURL.storeType, at: storeURL.rawValue, options: nil)
        XCTAssertTrue(objectModel.isConfiguration(withName: .configurationName, compatibleWithStoreMetadata: metadata))
        #endif
    }
}

private typealias Resource = String
private extension Resource {
    static let model_1_0_0_empty = "XcodeServer_1.0.0_empty"
    static let model_1_0_0_populated = "XcodeServer_1.0.0_full"
}
#endif
