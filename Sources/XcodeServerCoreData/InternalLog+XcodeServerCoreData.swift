import XcodeServer

public extension InternalLog {
    static let coreData: InternalLog = InternalLog(name: "XcodeServerCoreData.log", maxBytes: InternalLog.oneMB * 5)
}
