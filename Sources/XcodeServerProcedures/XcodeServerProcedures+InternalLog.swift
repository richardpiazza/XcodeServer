import XcodeServer

extension InternalLog {
    static let procedures: InternalLog = InternalLog(name: "XcodeServerProcedures.log", maxBytes: InternalLog.oneMB * 5)
}
