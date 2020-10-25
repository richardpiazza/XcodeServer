import Foundation

public extension Tests {
    ///
    struct Method: Hashable, Codable {
        public var name: String = ""
        public var deviceResults: [Tests.DeviceIdentifier: Int] = [:]
        
        public init() {
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Tests.CodingKeys.self)
            try container.allKeys.forEach { (key) in
                if let value = try container.decodeIfPresent(Int.self, forKey: key) {
                    deviceResults[key.stringValue] = value
                }
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Tests.CodingKeys.self)
            try deviceResults.forEach({
                if let key = Tests.CodingKeys(stringValue: $0.key) {
                    try container.encode($0.value, forKey: key)
                }
            })
        }
    }
}

public extension Tests.Method {
    var hasFailures: Bool {
        return deviceResults.contains(where: { $0.value == 0 })
    }
    
    /// A human-readable form of a method named (in particular XCTest method names).
    ///
    /// - example: testPerformSomeAction() -> 'Perform Some Action'
    var methodName: String {
        let characterSet = CharacterSet.uppercaseLetters
        
        var result = name
        result.replace(prefix: "test", with: nil)
        result.replace(suffix: "()", with: nil)
        
        for (index, character) in result.enumerated().reversed() {
            guard index > 0 else {
                continue
            }
            
            let thisCharacter = result.character(atIndex: index, isInCharacterSet: characterSet)
            let precedingCharacter = result.character(atIndex: index.advanced(by: -1), isInCharacterSet: characterSet)
            
            if thisCharacter && !precedingCharacter {
                let range = result.index(result.startIndex, offsetBy: index)...result.index(result.startIndex, offsetBy: index)
                result.replaceSubrange(range, with: " \(character)")
            }
        }
        
        return result
    }
}

private extension String {
    /// Replaces a specified prefix string with the provided string.
    mutating func replace(prefix: String, with: String?) {
        guard hasPrefix(prefix) else {
            return
        }
        
        let range = startIndex..<index(startIndex, offsetBy: prefix.count)
        if let with = with {
            replaceSubrange(range, with: with)
        } else {
            replaceSubrange(range, with: "")
        }
    }

    /// Replaces the specified suffix with the provided string.
    mutating func replace(suffix: String, with: String?) {
        guard hasSuffix(suffix) else {
            return
        }
        
        let range = index(endIndex, offsetBy: -suffix.count)..<endIndex
        if let with = with {
            replaceSubrange(range, with: with)
        } else {
            replaceSubrange(range, with: "")
        }
    }

    /// Determines if a character at a given index is a member of the provided character set.
    func character(atIndex index: Int, isInCharacterSet characterSet: CharacterSet) -> Bool {
        guard index >= 0 && index < self.count else {
            return false
        }
        
        let characterIndex = self.utf16.index(self.utf16.startIndex, offsetBy: index)
        let c = self.utf16[characterIndex]
        return characterSet.contains(UnicodeScalar(c)!)
    }
}
