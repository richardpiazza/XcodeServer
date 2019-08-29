import Foundation

public extension String {
    /// Replaces a specified prefix string with the provied string.
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
    
    /// ## xcServerTestMethodName
    /// Provides a human-readable form of a method named (in particular XCTest method names).
    /// - example: testPerformSomeAction() -> 'Perform Some Action'
    var xcServerTestMethodName: String {
        let characterSet = CharacterSet.uppercaseLetters
        
        var result = self
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
