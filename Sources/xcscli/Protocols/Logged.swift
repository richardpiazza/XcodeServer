import Foundation
import ArgumentParser
import XcodeServer

protocol Logged {
    var logLevel: InternalLog.Level { get set }
}

extension Logged {
    func configureLog() {
        InternalLog.api.minimumConsoleLevel = logLevel
        InternalLog.persistence.minimumConsoleLevel = logLevel
        InternalLog.operations.minimumConsoleLevel = logLevel
        InternalLog.utility.minimumConsoleLevel = logLevel
    }
}
