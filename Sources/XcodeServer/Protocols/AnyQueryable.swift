/// A source that conforms to all _queryable_ protocols.
public protocol AnyQueryable:
    BotQueryable, IntegrationQueryable, ServerQueryable, SourceControlQueryable {
}
