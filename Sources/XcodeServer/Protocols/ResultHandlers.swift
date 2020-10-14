import Foundation

public typealias AssetCatalogResultHandler = (Result<Integration.AssetCatalog, ResultError>) -> Void
public typealias BotResultHandler = (Result<Bot, ResultError>) -> Void
public typealias BotsResultHandler = (Result<[Bot], ResultError>) -> Void
public typealias BotStatsResultHandler = (Result<Bot.Stats, ResultError>) -> Void
public typealias CommitsResultHandler = (Result<[SourceControl.Commit], ResultError>) -> Void
public typealias DataResultHandler = (Result<Data, ResultError>) -> Void
public typealias IntegrationResultHandler = (Result<Integration, ResultError>) -> Void
public typealias IntegrationsResultHandler = (Result<[Integration], ResultError>) -> Void
public typealias IssueCatalogResultHandler = (Result<Integration.IssueCatalog, ResultError>) -> Void
public typealias RemoteResultHandler = (Result<SourceControl.Remote, ResultError>) -> Void
public typealias RemotesResultHandler = (Result<[SourceControl.Remote], ResultError>) -> Void
public typealias ServerResultHandler = (Result<Server, ResultError>) -> Void
public typealias ServersResultHandler = (Result<[Server], ResultError>) -> Void
public typealias VoidResultHandler = (Result<Void, ResultError>) -> Void
