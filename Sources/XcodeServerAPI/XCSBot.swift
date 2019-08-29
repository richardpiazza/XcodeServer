import Foundation

public struct XCSBot: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _id
        case _rev
        case group
        case requiresUpgrade
        case name
        case type
        case sourceControlBlueprintIdentifier
        case integrationCounter = "integration_counter"
        case docType = "doc_type"
        case tinyID
        case configuration
        case lastRevisionBlueprint
        case sourceControlBlueprint
    }
    
    public var _id: String
    public var _rev: String
    public var group: XCSGroup
    public var requiresUpgrade: Bool
    public var name: String
    public var type: Int
    public var sourceControlBlueprintIdentifier: String
    public var integrationCounter: Int
    public var docType: String
    public var tinyID: String
    public var configuration: XCSConfiguration?
    public var lastRevisionBlueprint: XCSRepositoryBlueprint?
    public var sourceControlBlueprint: XCSRepositoryBlueprint?
}
