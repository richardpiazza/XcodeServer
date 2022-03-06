import Foundation
import Logging
import Rainbow

struct ConsoleLogger: LogHandler {
    
    private static var bootstrapped: Bool = false
    private static var minimumLogLevel: Logger.Level = .info
    
    public static func bootstrap(minimumLogLevel: Logger.Level = .info) {
        guard !bootstrapped else {
            return
        }
        
        LoggingSystem.bootstrap(ConsoleLogger.init)
        bootstrapped = true
        self.minimumLogLevel = minimumLogLevel
    }
    
    static var gmtDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    let label: String
    var metadata: Logger.Metadata = .init()
    var logLevel: Logger.Level {
        get { Self.minimumLogLevel }
        set { Self.minimumLogLevel = newValue }
    }
    
    init(label: String) {
        self.label = label
    }
    
    subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        get {
            return metadata[key]
        }
        set(newValue) {
            metadata[key] = newValue
        }
    }
    
    func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
        let _date = Self.gmtDateFormatter.string(from: Date())
        let _file = URL(fileURLWithPath: file).lastPathComponent
        
        let dateAndLevel = [_date, level.defaultValueDescription].joined(separator: " ").cyan
        let sourceAndFile = [source, _file].joined(separator: " ").lightYellow
        let functionAndLine = [function, "\(line)"].joined(separator: " ").lightYellow
        
        let preamble = ["[", [dateAndLevel, sourceAndFile, functionAndLine].joined(separator: " | "), "]"].joined()
        
        var output = [preamble, message.description]
        if let metadata = metadata {
            output.append("\n{\n")
            output.append(contentsOf: metadata.map { "  \($0.key): \($0.value.description)\n".lightMagenta })
            output.append("}")
        }
        
        print(output.joined(separator: " "))
    }
}
