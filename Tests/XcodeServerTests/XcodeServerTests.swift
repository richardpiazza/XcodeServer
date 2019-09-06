import XCTest
@testable import XcodeServer
@testable import XcodeServerCommon
@testable import XcodeServerAPI
@testable import XcodeServerCoreData

final class XcodeServerTests: XCTestCase {
    
    static var allTests = [
        ("testModel_1_0_0_Hashes", testModel_1_0_0_Hashes),
        ("testModel_1_0_0_Initialization", testModel_1_0_0_Initialization),
    ]
    
    lazy var model: NSManagedObjectModel = {
        return Model_1_0_0()
    }()
    
    func testModel_1_0_0_Hashes() {
        let entityHashes = model.entityVersionHashesByName
        
        XCTAssertEqual(entityHashes[Asset.entityName]!.hexString, "e26ed40dd5f67926b82284c93ff43345873e127230d177d63bc7c460ce02b22e")
        XCTAssertEqual(entityHashes[Bot.entityName]!.hexString, "f48bd2d1fb3e0eae713ceb654e247dee992a39ba29776339e0c5178f935acdd5")
        XCTAssertEqual(entityHashes[BuildResultSummary.entityName]!.hexString, "bcccab1f241de0fd2ae266b8d9f0b419cc30cce281e0898564e851c3f6300528")
        XCTAssertEqual(entityHashes[Commit.entityName]!.hexString, "d5072780a250ba08ae20cbb11ad3cde0b705c3bf6aee7b4b84108b147bcb2ab6")
        XCTAssertEqual(entityHashes[CommitChange.entityName]!.hexString, "55bbc6abfc7b1d6ef6497cbaf3482c11805e09b6707cda708b8a7bad40c98f41")
        XCTAssertEqual(entityHashes[CommitContributor.entityName]!.hexString, "eb4840a647e444fa96e304d99c54dac6ea03c3515727eb8f4aae95fa36f35af1")
        XCTAssertEqual(entityHashes[Conditions.entityName]!.hexString, "43c75d8892334f5bb1ffc69d71366cc8341354bac4f5dda12d2cf04d1e4bbc29")
        XCTAssertEqual(entityHashes[Configuration.entityName]!.hexString, "fd2005a5c47103c342feb35f0c98f3adbfa3b2ef34b96bffb366946214a71a16")
        XCTAssertEqual(entityHashes[Device.entityName]!.hexString, "d7970b54509ea67e7b6a113095e1ee4df1dce98b63d2b5fbb22fbd5c1740d37a")
        XCTAssertEqual(entityHashes[DeviceSpecification.entityName]!.hexString, "d2f8ec60efc6be84488669ff6da365698d2299b895dfba81ebfd504a3e54f7fd")
        XCTAssertEqual(entityHashes[EmailConfiguration.entityName]!.hexString, "f787388ef7067b89ce93edcdf608aa062be90e1dce38afec535d29eed5f8c99b")
        XCTAssertEqual(entityHashes[Filter.entityName]!.hexString, "8543c3213eb7d51686e691f1ee4f7289ce2b85e161a3aa3874268d6939ab9232")
        XCTAssertEqual(entityHashes[Integration.entityName]!.hexString, "7ab399068ba8fd22fb24c3762671397ff50519ff2db43232d57a19caa36998bb")
        XCTAssertEqual(entityHashes[IntegrationAssets.entityName]!.hexString, "e4a0616aabb373aa0e0d81c5beb59684145f2a06b956ca41683c99b4ba8be987")
        XCTAssertEqual(entityHashes[IntegrationIssues.entityName]!.hexString, "362e374eae06027aea5fc37ef4dc459b99b0e676b99938566027a00840bf3b50")
        XCTAssertEqual(entityHashes[Issue.entityName]!.hexString, "dfdf16f6c261c16ce8c9b4c6c595b93506eed4555cf2f82be9aff35bdb274bcc")
        XCTAssertEqual(entityHashes[Platform.entityName]!.hexString, "b2fb4c24000708e7b707685a7c3318b89e6504e8fc58c16e5482f7cff6be6049")
        XCTAssertEqual(entityHashes[Repository.entityName]!.hexString, "4fd5ac1694bf0ab40310d16ceb82db5dcd830d962587264bef16678940831022")
        XCTAssertEqual(entityHashes[RevisionBlueprint.entityName]!.hexString, "d286d43fdd6a0cbf8300dab3da1861faa734fc32c0483802653ab6ed05d450ce")
        XCTAssertEqual(entityHashes[Server.entityName]!.hexString, "1a907887cecfd18bab0ff3854234aa67a118a63aa72795802f835fe7a781eacd")
        XCTAssertEqual(entityHashes[Stats.entityName]!.hexString, "3b4f4c9e57bb4e66d26d9ae7661f3581cf8f79988090a694bccd7a36cb451910")
        XCTAssertEqual(entityHashes[StatsBreakdown.entityName]!.hexString, "3ba796b703addd47ac6f505cf4b1e8222a0ede27b5fc4e37e5d48f6716bcfd5c")
        XCTAssertEqual(entityHashes[Trigger.entityName]!.hexString, "b5648ee5d889e1c901859f27a756d77cce392f815227367206d2c1c32c27312e")
    }
    
    func testModel_1_0_0_Initialization() {
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
    }
    
//    func testModel_1_0_0_Metadata() throws {
//        let bundle = Bundle(for: XcodeServerTests.self)
//
//        guard let url = bundle.url(forResource: "XcodeServer_1.0.0_empty", withExtension: "sqlite") else {
//            throw CocoaError(.fileNoSuchFile)
//        }
//
//        let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: url, options: nil)
//
//        XCTAssertTrue(model.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata))
//    }
}
