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
        #if canImport(CoreData)
        let entityHashes = model.entityVersionHashesByName
        
        XCTAssertEqual(entityHashes[Asset.entityName]!.hexString, "e26ed40dd5f67926b82284c93ff43345873e127230d177d63bc7c460ce02b22e")
        XCTAssertEqual(entityHashes[Bot.entityName]!.hexString, "25c74c90cd2544b98b58566cf1748cd678597cd5bc952ed701f453582260f8a1")
        XCTAssertEqual(entityHashes[BuildResultSummary.entityName]!.hexString, "bcccab1f241de0fd2ae266b8d9f0b419cc30cce281e0898564e851c3f6300528")
        XCTAssertEqual(entityHashes[Commit.entityName]!.hexString, "43c6115422b86105f6a2e2b1da7c42f69ea7bbcfc94ec5192c8ba1f964e5812b")
        XCTAssertEqual(entityHashes[CommitChange.entityName]!.hexString, "2ccf91f434c8c79b5a1bf76dbd7b20d100fb924195492e74b55f37058f54d0b6")
        XCTAssertEqual(entityHashes[CommitContributor.entityName]!.hexString, "eb4840a647e444fa96e304d99c54dac6ea03c3515727eb8f4aae95fa36f35af1")
        XCTAssertEqual(entityHashes[Conditions.entityName]!.hexString, "a989cc224be1a41d62e22ce15b0de3099edd02d2e9b6c9f50d16cd849624bb4d")
        XCTAssertEqual(entityHashes[Configuration.entityName]!.hexString, "3f9bd5ff21b75177030e735bd6fbc83c233d4478ff83ab45f74248ce2e2bae38")
        XCTAssertEqual(entityHashes[Device.entityName]!.hexString, "46327457a8fab28bebda9a82e9fb852323a542220c4c539aeaa4ec60e9acb769")
        XCTAssertEqual(entityHashes[DeviceSpecification.entityName]!.hexString, "d2f8ec60efc6be84488669ff6da365698d2299b895dfba81ebfd504a3e54f7fd")
        XCTAssertEqual(entityHashes[EmailConfiguration.entityName]!.hexString, "1cd43bf8b3f8993bf3f03d408702edfd012b25051b383f16ae4376aba9af2532")
        XCTAssertEqual(entityHashes[Filter.entityName]!.hexString, "c4eea57971b9505650840db7ed03bcc70f6b03774e0156a102b8d1e11580f34c")
        XCTAssertEqual(entityHashes[Integration.entityName]!.hexString, "6f485d4fc090e24bedc179da596346d5381b304d7539a59d48fa876fc3e84e24")
        XCTAssertEqual(entityHashes[IntegrationAssets.entityName]!.hexString, "e4a0616aabb373aa0e0d81c5beb59684145f2a06b956ca41683c99b4ba8be987")
        XCTAssertEqual(entityHashes[IntegrationIssues.entityName]!.hexString, "362e374eae06027aea5fc37ef4dc459b99b0e676b99938566027a00840bf3b50")
        XCTAssertEqual(entityHashes[Issue.entityName]!.hexString, "7a7117a08f8060fbc30050658493064cede40214ec1254ebd6eeb800939487e0")
        XCTAssertEqual(entityHashes[Platform.entityName]!.hexString, "c017f0c462fac8892967b95ca5a9146d9559eaf07b77702d7281f4345c0fb855")
        XCTAssertEqual(entityHashes[Repository.entityName]!.hexString, "3aa5bcf326bf07fb21d32388f45aea44b9b76d8c7e16d979229b438d11d25941")
        XCTAssertEqual(entityHashes[RevisionBlueprint.entityName]!.hexString, "d286d43fdd6a0cbf8300dab3da1861faa734fc32c0483802653ab6ed05d450ce")
        XCTAssertEqual(entityHashes[Server.entityName]!.hexString, "1a907887cecfd18bab0ff3854234aa67a118a63aa72795802f835fe7a781eacd")
        XCTAssertEqual(entityHashes[Stats.entityName]!.hexString, "3b4f4c9e57bb4e66d26d9ae7661f3581cf8f79988090a694bccd7a36cb451910")
        XCTAssertEqual(entityHashes[StatsBreakdown.entityName]!.hexString, "8b2f1bdac6b3b54862cc6ee0e43698a26fa594b3157b893e205e4d8d12b1b71f")
        XCTAssertEqual(entityHashes[Trigger.entityName]!.hexString, "fb6787e679b81cf51bda2e905e219a23bf68a4e853e6f3ff35598e2d693abc90")
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
