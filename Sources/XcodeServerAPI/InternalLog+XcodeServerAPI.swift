import XcodeServer

public extension InternalLog {
    static let apiClient: InternalLog = InternalLog(name: "XcodeServerAPI.log", maxBytes: InternalLog.oneMB * 5)
}
