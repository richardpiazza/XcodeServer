import XcodeServer

public extension InternalLog {
    static let procedures: InternalLog = InternalLog(name: "XcodeServerProcedures.log", maxBytes: InternalLog.oneMB * 5)
}
