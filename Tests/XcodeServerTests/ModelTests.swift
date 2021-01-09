import XCTest
@testable import XcodeServer
@testable import XcodeServerCoreData
@testable import XcodeServerPersistence
@testable import XcodeServerModel_1_0_0
@testable import XcodeServerModel_1_1_0
#if canImport(CoreData)
import CoreData

final class ModelTests: XCTestCase {
    
    static var allTests = [
        ("testModel_1_0_0_Hashes", testModel_1_0_0_Hashes),
        ("testModel_1_1_0_Hashes", testModel_1_1_0_Hashes),
    ]
    
    func testModel_1_0_0_Hashes() throws {
        let model: Model = .v1_0_0
        let managedObjectModel = model.managedObjectModel
        let entityHashes = managedObjectModel.entityVersionHashesByName
        try model.verifyHashes(entityHashes)
    }
    
    func testModel_1_1_0_Hashes() throws {
        let model: Model = .v1_1_0
        let managedObjectModel = model.managedObjectModel
        let entityHashes = managedObjectModel.entityVersionHashesByName
        try model.verifyHashes(entityHashes)
    }
}

extension Model {
    func verifyHashes(_ entityHashes: [String: Data]) throws {
        switch self {
        case .v1_0_0:
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Asset.entityName]!.hexString, "b31a95b5bd19f89ddfe7e0fcedd7d7cb8be8b49b83a0a4b0d7ed2b533c99cce7")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Bot.entityName]!.hexString, "3cff8578a69bd56fefa0c8e7c189c1b21152c55c40db63c888bf2eb262f07ad4")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.BuildResultSummary.entityName]!.hexString, "b45af7a898d755de61847ce09873c2f416728d1b74eeed6b0c0a7f140f78512b")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Commit.entityName]!.hexString, "98fb8caa20897017c01ebdeadbb156f7f448f5cd20921fb76e14cd4a9ce54837")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.CommitChange.entityName]!.hexString, "0c65df704697030c0a0d105523937ac405689eb42b59be917f497c75040dfc1f")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.CommitContributor.entityName]!.hexString, "cc64f49c101b11d3964386abebd4a21ffd209e60fbfb8bff57567fbeb2c7f578")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Conditions.entityName]!.hexString, "a92447c7552a403e70841945f00fbc647a469fa590c2f47b3a1d27c5da7e4870")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Configuration.entityName]!.hexString, "62c47f55128015eba4aff2e80f4eb1db5b26c30d33f27593fd89aed654a098f5")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Device.entityName]!.hexString, "92aa9690c28a3eba158ddfca2f0074c0e2d0d3b9618dab472eee9e0d090af28c")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.DeviceSpecification.entityName]!.hexString, "9f064ed325a44b5ab581712a6803709ce43312c1121b4291590d81799eb343e1")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.EmailConfiguration.entityName]!.hexString, "009accf006536063e90fbb2959f3c354dd7212900a147285a448fffbc5c6e728")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Filter.entityName]!.hexString, "1fbdad4eb0270a0559a9555fd795e0a6b661870f0b8d48970f9a0b0a26fcc45c")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Integration.entityName]!.hexString, "36e4884401b75a36aca24373cff2927f9d936c5fdcabb3242392dc85c1c392ac")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.IntegrationAssets.entityName]!.hexString, "fd9ae0c7e9f920c38026faf3d69cc44f0fe90d6b628249cb36648489bbbfb739")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.IntegrationIssues.entityName]!.hexString, "538aebeb1e951e4ba198472301a93cf6d438eb9c5e55286e12ae95921a2b0f59")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Issue.entityName]!.hexString, "b2e346672195e5b85bfb627e774d21d4420fc294b979d989c9856acdcd6cf26a")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Platform.entityName]!.hexString, "4af643407b6b06bad810be66637e2e13b6f1f5611946325f564da0dc7f2a5f06")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Repository.entityName]!.hexString, "20e01482049505b6430efa5e1af9ecb6618a6a08239673f04fbd7c59be5bac4b")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.RevisionBlueprint.entityName]!.hexString, "ace49f92ed91bb675d566997595288d371a0459b3c63b4b847e43d144f0f8417")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Server.entityName]!.hexString, "00020c5a7034bd6d43ed2863a12098e75e4dedec61b4e4ca00a8f0e194ce7191")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Stats.entityName]!.hexString, "79bcb629782295d52edf512f759bb21574093fca766c5805b447b67a135a9641")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.StatsBreakdown.entityName]!.hexString, "9c2242bd3bf357e3d205c82a649fd8069add177cad53a0c43d31a8d24454f98e")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_0_0.Trigger.entityName]!.hexString, "588238886b3c6f153e95108032277a25bd43f2efd0b8e01ea7c7abb9c8dd8298")
        case .v1_1_0:
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Asset.entityName]!.hexString, "b31a95b5bd19f89ddfe7e0fcedd7d7cb8be8b49b83a0a4b0d7ed2b533c99cce7")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Bot.entityName]!.hexString, "3cff8578a69bd56fefa0c8e7c189c1b21152c55c40db63c888bf2eb262f07ad4")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.BuildResultSummary.entityName]!.hexString, "b45af7a898d755de61847ce09873c2f416728d1b74eeed6b0c0a7f140f78512b")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Commit.entityName]!.hexString, "98fb8caa20897017c01ebdeadbb156f7f448f5cd20921fb76e14cd4a9ce54837")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.CommitChange.entityName]!.hexString, "0c65df704697030c0a0d105523937ac405689eb42b59be917f497c75040dfc1f")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.CommitContributor.entityName]!.hexString, "cc64f49c101b11d3964386abebd4a21ffd209e60fbfb8bff57567fbeb2c7f578")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Conditions.entityName]!.hexString, "a92447c7552a403e70841945f00fbc647a469fa590c2f47b3a1d27c5da7e4870")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Configuration.entityName]!.hexString, "62c47f55128015eba4aff2e80f4eb1db5b26c30d33f27593fd89aed654a098f5")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Device.entityName]!.hexString, "92aa9690c28a3eba158ddfca2f0074c0e2d0d3b9618dab472eee9e0d090af28c")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.DeviceSpecification.entityName]!.hexString, "9f064ed325a44b5ab581712a6803709ce43312c1121b4291590d81799eb343e1")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.EmailConfiguration.entityName]!.hexString, "009accf006536063e90fbb2959f3c354dd7212900a147285a448fffbc5c6e728")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Filter.entityName]!.hexString, "1fbdad4eb0270a0559a9555fd795e0a6b661870f0b8d48970f9a0b0a26fcc45c")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Integration.entityName]!.hexString, "36e4884401b75a36aca24373cff2927f9d936c5fdcabb3242392dc85c1c392ac")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.IntegrationAssets.entityName]!.hexString, "fd9ae0c7e9f920c38026faf3d69cc44f0fe90d6b628249cb36648489bbbfb739")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.IntegrationIssues.entityName]!.hexString, "21d9c7db0b754807a5953844055fc45446bdc0a16db3315362338f795115c3fa")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Issue.entityName]!.hexString, "ea534782633915e3bfa7984802fcf7a1dc7b03416f2cabb3ff5ddeea320a24e5")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Platform.entityName]!.hexString, "4af643407b6b06bad810be66637e2e13b6f1f5611946325f564da0dc7f2a5f06")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Repository.entityName]!.hexString, "20e01482049505b6430efa5e1af9ecb6618a6a08239673f04fbd7c59be5bac4b")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.RevisionBlueprint.entityName]!.hexString, "ace49f92ed91bb675d566997595288d371a0459b3c63b4b847e43d144f0f8417")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Server.entityName]!.hexString, "00020c5a7034bd6d43ed2863a12098e75e4dedec61b4e4ca00a8f0e194ce7191")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Stats.entityName]!.hexString, "79bcb629782295d52edf512f759bb21574093fca766c5805b447b67a135a9641")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.StatsBreakdown.entityName]!.hexString, "9c2242bd3bf357e3d205c82a649fd8069add177cad53a0c43d31a8d24454f98e")
            XCTAssertEqual(entityHashes[XcodeServerModel_1_1_0.Trigger.entityName]!.hexString, "588238886b3c6f153e95108032277a25bd43f2efd0b8e01ea7c7abb9c8dd8298")
        }
    }
}
#endif
