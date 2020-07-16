public struct XCSArchiveExportOptions: Codable {
    public var name: String?
    /// Date with format: '2020-06-23T21:46:09.234Z'
    public var createdAt: String?
    /// For example: "iCloudContainerEnvironment": "Production"
    public var exportOptions: XCSExportOptions?
}
