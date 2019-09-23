import XCTest
@testable import XcodeServer
@testable import XcodeServerCommon
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

final class XcodeServerTests: XCTestCase {
    
    static var allTests = [
        ("testModel_1_0_0_Hashes", testModel_1_0_0_Hashes),
        ("testModel_1_0_0_Initialization", testModel_1_0_0_Initialization),
        ("testEmptyStore_Model_1_0_0_Metadata", testEmptyStore_Model_1_0_0_Metadata),
        ("testFullStore_Model_1_0_0_Metadata", testFullStore_Model_1_0_0_Metadata),
    ]
    
    lazy var model: NSManagedObjectModel = {
        return Model_1_0_0.instance
    }()
    
    func testModel_1_0_0_Hashes() {
        #if canImport(CoreData)
        let entityHashes = model.entityVersionHashesByName
        
        XCTAssertEqual(entityHashes[Asset.entityName]!.hexString, "b31a95b5bd19f89ddfe7e0fcedd7d7cb8be8b49b83a0a4b0d7ed2b533c99cce7")
        XCTAssertEqual(entityHashes[Bot.entityName]!.hexString, "3cff8578a69bd56fefa0c8e7c189c1b21152c55c40db63c888bf2eb262f07ad4")
        XCTAssertEqual(entityHashes[BuildResultSummary.entityName]!.hexString, "b45af7a898d755de61847ce09873c2f416728d1b74eeed6b0c0a7f140f78512b")
        XCTAssertEqual(entityHashes[Commit.entityName]!.hexString, "98fb8caa20897017c01ebdeadbb156f7f448f5cd20921fb76e14cd4a9ce54837")
        XCTAssertEqual(entityHashes[CommitChange.entityName]!.hexString, "0c65df704697030c0a0d105523937ac405689eb42b59be917f497c75040dfc1f")
        XCTAssertEqual(entityHashes[CommitContributor.entityName]!.hexString, "cc64f49c101b11d3964386abebd4a21ffd209e60fbfb8bff57567fbeb2c7f578")
        XCTAssertEqual(entityHashes[Conditions.entityName]!.hexString, "a92447c7552a403e70841945f00fbc647a469fa590c2f47b3a1d27c5da7e4870")
        XCTAssertEqual(entityHashes[Configuration.entityName]!.hexString, "62c47f55128015eba4aff2e80f4eb1db5b26c30d33f27593fd89aed654a098f5")
        XCTAssertEqual(entityHashes[Device.entityName]!.hexString, "92aa9690c28a3eba158ddfca2f0074c0e2d0d3b9618dab472eee9e0d090af28c")
        XCTAssertEqual(entityHashes[DeviceSpecification.entityName]!.hexString, "9f064ed325a44b5ab581712a6803709ce43312c1121b4291590d81799eb343e1")
        XCTAssertEqual(entityHashes[EmailConfiguration.entityName]!.hexString, "f1737ba69b80bf11387db0857e9f8447146fe2203d40b0c114c0d9f5e7f71e97")
        XCTAssertEqual(entityHashes[Filter.entityName]!.hexString, "1fbdad4eb0270a0559a9555fd795e0a6b661870f0b8d48970f9a0b0a26fcc45c")
        XCTAssertEqual(entityHashes[Integration.entityName]!.hexString, "36e4884401b75a36aca24373cff2927f9d936c5fdcabb3242392dc85c1c392ac")
        XCTAssertEqual(entityHashes[IntegrationAssets.entityName]!.hexString, "fd9ae0c7e9f920c38026faf3d69cc44f0fe90d6b628249cb36648489bbbfb739")
        XCTAssertEqual(entityHashes[IntegrationIssues.entityName]!.hexString, "538aebeb1e951e4ba198472301a93cf6d438eb9c5e55286e12ae95921a2b0f59")
        XCTAssertEqual(entityHashes[Issue.entityName]!.hexString, "b2e346672195e5b85bfb627e774d21d4420fc294b979d989c9856acdcd6cf26a")
        XCTAssertEqual(entityHashes[Platform.entityName]!.hexString, "4af643407b6b06bad810be66637e2e13b6f1f5611946325f564da0dc7f2a5f06")
        XCTAssertEqual(entityHashes[Repository.entityName]!.hexString, "20e01482049505b6430efa5e1af9ecb6618a6a08239673f04fbd7c59be5bac4b")
        XCTAssertEqual(entityHashes[RevisionBlueprint.entityName]!.hexString, "ace49f92ed91bb675d566997595288d371a0459b3c63b4b847e43d144f0f8417")
        XCTAssertEqual(entityHashes[Server.entityName]!.hexString, "00020c5a7034bd6d43ed2863a12098e75e4dedec61b4e4ca00a8f0e194ce7191")
        XCTAssertEqual(entityHashes[Stats.entityName]!.hexString, "79bcb629782295d52edf512f759bb21574093fca766c5805b447b67a135a9641")
        XCTAssertEqual(entityHashes[StatsBreakdown.entityName]!.hexString, "9c2242bd3bf357e3d205c82a649fd8069add177cad53a0c43d31a8d24454f98e")
        XCTAssertEqual(entityHashes[Trigger.entityName]!.hexString, "588238886b3c6f153e95108032277a25bd43f2efd0b8e01ea7c7abb9c8dd8298")
        #endif
    }
    
    func testModel_1_0_0_Initialization() {
        #if canImport(CoreData)
        let exp = expectation(description: "\(#function)")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.url = nil
        description.shouldInferMappingModelAutomatically = false
        description.shouldMigrateStoreAutomatically = false
        
        let container = NSPersistentContainer.init(name: "XcodeServer", managedObjectModel: model)
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
        #if canImport(CoreData)
        let bundle = Bundle(for: XcodeServerTests.self)

        guard let url = bundle.url(forResource: "XcodeServer_1.0.0_empty", withExtension: "sqlite") else {
            throw CocoaError(.fileNoSuchFile)
        }

        let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: url, options: nil)

        XCTAssertTrue(model.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata))
        #endif
    }
    
    func testFullStore_Model_1_0_0_Metadata() throws {
        #if canImport(CoreData)
        let bundle = Bundle(for: XcodeServerTests.self)
        
        guard let url = bundle.url(forResource: "XcodeServer_1.0.0_full", withExtension: "sqlite") else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: url, options: nil)
        
        XCTAssertTrue(model.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata))
        #endif
    }
}
