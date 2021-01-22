import Foundation

/// A General Purpose Log
public class InternalLog {
    
    /// The distinguishing severity of a Log Entry.
    public enum Level: String, Codable, CaseIterable {
        case debug
        case info
        case warn
        case error
        
        /// A string representation of the level that include padding for a consistent length
        public var paddedRawValue: RawValue {
            guard let maxCount = type(of: self).allCases.map({ $0.rawValue.count }).max() else {
                return rawValue
            }
            
            return rawValue.padding(toLength: maxCount, withPad: " ", startingAt: 0)
        }
        
        /// A little bit of ~fun~ visual distinction for the log entry.
        public var gem: String {
            switch self {
            case .debug: return "🦠"
            case .info: return "🔎"
            case .warn: return "⚠️"
            case .error: return "🚫"
            }
        }
        
        /// A rank-able value used in determining minimums.
        public var rank: Int {
            switch self {
            case .debug: return 0
            case .info: return 1
            case .warn: return 2
            case .error: return 3
            }
        }
    }
    
    /// Representation of a single log item
    public struct Entry: Codable {
        public let date: Date
        public let level: Level
        public let message: String
        public let error: Error?
        public let file: String
        public let line: Int
        public let localTimeZone: Bool
        
        private enum CodingKeys: String, CodingKey {
            case date
            case level
            case message
            case error
            case file
            case line
            case localTimeZone
        }
        
        private enum WrappedError: Error, LocalizedError {
            case wrapped(error: String)
            
            var errorDescription: String? {
                switch self {
                case .wrapped(let error):
                    return error
                }
            }
        }
        
        private static var gmtDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss'Z'"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter
        }()
        
        private static var localDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            formatter.timeZone = TimeZone.autoupdatingCurrent
            return formatter
        }()
        
        private static var jsonEncoder: JSONEncoder = {
            let encoder = JSONEncoder()
            if #available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *) {
                encoder.dateEncodingStrategy = .iso8601
            } else {
                encoder.dateEncodingStrategy = .formatted(gmtDateFormatter)
            }
            return encoder
        }()
        
        public init(level: Level, message: String, error: Error?, file: String, line: Int, localTimeZone: Bool = false) {
            self.date = Date()
            self.level = level
            self.message = message
            self.error = error
            self.file = file
            self.line = line
            self.localTimeZone = localTimeZone
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            date = try container.decode(Date.self, forKey: .date)
            level = try container.decode(Level.self, forKey: .level)
            message = try container.decode(String.self, forKey: .message)
            if let value = try container.decodeIfPresent(String.self, forKey: .error) {
                error = WrappedError.wrapped(error: value)
            } else {
                error = nil
            }
            file = try container.decode(String.self, forKey: .file)
            line = try container.decode(Int.self, forKey: .line)
            localTimeZone = try container.decode(Bool.self, forKey: .localTimeZone)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(date, forKey: .date)
            try container.encode(level, forKey: .level)
            try container.encode(message, forKey: .message)
            try container.encode(error?.localizedDescription, forKey: .error)
            try container.encode(file, forKey: .file)
            try container.encode(line, forKey: .line)
            try container.encode(localTimeZone, forKey: .localTimeZone)
        }
        
        /// The name component of the file path
        public var fileName: String {
            return URL(fileURLWithPath: file).lastPathComponent
        }
        
        /// Date formatted to the for the time zone preference
        public var formattedDate: String {
            if localTimeZone {
                return Entry.localDateFormatter.string(from: date)
            } else {
                return Entry.gmtDateFormatter.string(from: date)
            }
        }
        
        /// A standardize format for printing/writing log entries.
        /// For example: [2019-03-06 04:31:34Z 🦠 DEBUG at Log.playground 16] Testing
        public var formattedString: String {
            var output = "[\(formattedDate) \(level.gem) \(level.paddedRawValue.uppercased()) at \(fileName) \(line)] \(message)"
            if let error = error {
                output += " \(error.localizedDescription)"
            }
            
            return output
        }
        
        /// A dictionary representation of this entry
        public var dictionary: [String : Any] {
            let data: Data
            do {
                data = try Entry.jsonEncoder.encode(self)
            } catch {
                return [:]
            }
            
            let dictionary: [String : Any]
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                dictionary = object as? [String : Any] ?? [:]
            } catch {
                return [:]
            }
            
            return dictionary
        }
        
        /// A `Data` representation of the `formattedString`
        public var data: Data? {
            return formattedString.data(using: .utf8)
        }
        
        /// A `Data` representation with an appended new line character
        public var dataForWriting: Data? {
            return formattedString.appending("\n").data(using: .utf8)
        }
    }
    
    /// The default shared log implementation
    public static let `default`: InternalLog = InternalLog(name: "XcodeServer.log", maxBytes: InternalLog.oneMB * 5)
    public static let api: InternalLog = InternalLog(name: "XcodeServerAPI.log", maxBytes: InternalLog.oneMB * 5)
    public static let operations: InternalLog = InternalLog(name: "XcodeServerProcedures.log", maxBytes: InternalLog.oneMB * 5)
    public static let persistence: InternalLog = InternalLog(name: "XcodeServerCoreData.log", maxBytes: InternalLog.oneMB * 5)
    public static let utility: InternalLog = InternalLog(name: "XcodeServerUtility.log", maxBytes: InternalLog.oneMB * 5)
    
    /// The default max log size
    public static let oneMB: UInt = 1024 * 1024 * 1
    
    /// The on-disk `URL` of the log
    public private(set) var fileUrl: URL?
    
    /// The max disk capacity the log is allowed to consume before being purged.
    public private(set) var maxBytes: UInt?
    
    /// Indicates log activity should be 'printed' to the console.
    public var outputToConsole: Bool = true
    
    /// The minimum level that should be output to console
    public var minimumConsoleLevel: Level = .debug
    
    /// The minimum level that should be output to file/disk
    public var minimumFileLevel: Level = .debug
    
    /// Should `Date` be formatted for the local `TimeZone` or GMT.
    public var localTimeZone: Bool = false
    
    /// The current disk capacity this log is consuming
    public var bytes: UInt? {
        return fileSize()
    }
    
    /// A `Data` representation of the log
    public var data: Data? {
        return fileData()
    }
    
    public init() {
        
    }
    
    public convenience init(name: String, maxBytes: UInt? = InternalLog.oneMB) {
        self.init()
        self.fileUrl = FileManager.default.xcodeServerDirectory.appendingPathComponent(name)
        self.maxBytes = maxBytes
    }
    
    /// Convenience method for logging a 'Debug' message to the default `Log`.
    public static func debug(_ message: String, file: String = #file, line: Int = #line) {
        `default`.debug(message, file: file, line: line)
    }
    
    /// Convenience method for logging a 'Info' message to the default `Log`.
    public static func info(_ message: String, file: String = #file, line: Int = #line) {
        `default`.info(message, file: file, line: line)
    }
    
    /// Convenience method for logging a 'Warn' message to the default `Log`.
    public static func warn(_ message: String, file: String = #file, line: Int = #line) {
        `default`.warn(message, file: file, line: line)
    }
    
    /// Convenience method for logging a 'Error' message to the default `Log`.
    public static func error(_ error: Error? = nil, message: String, file: String = #file, line: Int = #line) {
        `default`.error(message, error: error, file: file, line: line)
    }
    
    /// Convenience method for logging a 'Error' message to the default `Log`.
    /// Matches an older 'log' implementation signature to ensure drop-in replacement.
    public static func error(_ message: String, error: Error? = nil, file: String = #file, line: Int = #line) {
        `default`.error(message, error: error, file: file, line: line)
    }
    
    public func debug(_ message: String, file: String = #file, line: Int = #line) {
        log(.debug, message: message, file: file, line: line, error: nil)
    }
    
    public func info(_ message: String, file: String = #file, line: Int = #line) {
        log(.info, message: message, file: file, line: line, error: nil)
    }
    
    public func warn(_ message: String, file: String = #file, line: Int = #line) {
        log(.warn, message: message, file: file, line: line, error: nil)
    }
    
    public func error(_ message: String, error: Error?, file: String = #file, line: Int = #line) {
        log(.error, message: message, file: file, line: line, error: error)
    }
    
    public func clear() {
        purge()
    }
    
    private func log(_ level: Level, message: String, file: String, line: Int, error: Error?) {
        let entry = Entry(level: level, message: message, error: error, file: file, line: line, localTimeZone: localTimeZone)
        
        if outputToConsole && level.rank >= minimumConsoleLevel.rank {
            print(entry.formattedString)
        }
        
        if let data = entry.dataForWriting, level.rank >= minimumFileLevel.rank {
            write(data: data)
        }
    }
    
    private func write(data: Data) {
        if let size = fileSize(), let maxBytes = self.maxBytes, size > maxBytes {
            purge()
        }
        
        guard let url = self.fileUrl else {
            return
        }
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            do {
                try data.write(to: url, options: .atomic)
            } catch {
                InternalLog.error("", error: error)
            }
            return
        }
        
        var handle: FileHandle
        do {
            handle = try FileHandle(forWritingTo: url)
        } catch {
            InternalLog.error("", error: error)
            return
        }
        
        let _ = handle.seekToEndOfFile()
        handle.write(data)
        handle.closeFile()
    }
    
    private func fileSize() -> UInt? {
        guard let url = self.fileUrl else {
            return nil
        }
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        let attributes: [FileAttributeKey : Any]
        do {
            attributes = try FileManager.default.attributesOfItem(atPath: url.path)
        } catch {
            InternalLog.error("", error: error)
            return nil
        }
        
        guard let bytes = attributes[FileAttributeKey.size] as? UInt else {
            return nil
        }
        
        return bytes
    }
    
    private func fileData() -> Data? {
        guard let url = self.fileUrl else {
            return nil
        }
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        var data: Data?
        do {
            data = try Data(contentsOf: url)
        } catch {
            InternalLog.error("", error: error)
        }
        
        return data
    }
    
    private func purge() {
        guard let url = self.fileUrl else {
            return
        }
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            InternalLog.error("", error: error)
        }
    }
}

public extension InternalLog {
    @available(*, deprecated, renamed: "api")
    static var apiClient: InternalLog { .api }
    
    @available(*, deprecated, renamed: "persistence")
    static var coreData: InternalLog { .persistence }
    
    @available(*, deprecated, renamed: "operations")
    static var procedures: InternalLog { .operations }
}
