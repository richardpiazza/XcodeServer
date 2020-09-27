/// A source that conforms to all _persistable_ types
public protocol AnyPersistable:
    BotPersistable, IntegrationPersistable, ServerPersistable, SourceControlPersistable {
}
