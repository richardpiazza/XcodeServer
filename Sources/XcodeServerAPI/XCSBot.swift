import Foundation

public struct XCSBot: Codable {
    
    enum CodingKeys: String, CodingKey {
        case configuration
        case docType = "doc_type"
        case group
        case identifier = "_id"
        case integrationCounter = "integration_counter"
        case lastRevisionBlueprint
        case name
        case requiresUpgrade
        case sourceControlBlueprint
        case sourceControlBlueprintIdentifier
        case typeRawValue = "type"
    }
    
    public var configuration: XCSConfiguration?
    public var docType: String = "bot"
    public var group: XCSGroup = XCSGroup()
    public var identifier: UUID = UUID()
    public var integrationCounter: Int = 0
    public var lastRevisionBlueprint: XCSRepositoryBlueprint?
    public var name: String = ""
    public var requiresUpgrade: Bool = false
    public var sourceControlBlueprint: XCSRepositoryBlueprint?
    public var sourceControlBlueprintIdentifier: String = ""
    public var typeRawValue: Int = 0
}
