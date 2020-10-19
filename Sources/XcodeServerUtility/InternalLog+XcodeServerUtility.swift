import XcodeServer

public extension InternalLog {
    static let utility: InternalLog = InternalLog(name: "XcodeServerUtility.log", maxBytes: InternalLog.oneMB * 5)
}
