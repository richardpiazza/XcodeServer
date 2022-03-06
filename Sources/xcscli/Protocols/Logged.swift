import Foundation
import ArgumentParser
import Logging

protocol Logged {
    var logLevel: Logger.Level { get set }
}
