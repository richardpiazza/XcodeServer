public extension SourceControl {
    
    struct Contributor: Hashable {
        public var name: String = ""
        public var displayName: String = ""
        public var emails: [String] = []
        
        public init() {
        }
    }
}

public extension SourceControl.Contributor {
    var initials: String? {
        let components: [String]
        
        if !name.isEmpty {
            components = name.components(separatedBy: " ")
        } else if !displayName.isEmpty {
            components = displayName.components(separatedBy: " ")
        } else {
            return nil
        }
        
        var initials = ""
        
        for component in components {
            guard component != "" else {
                continue
            }
            
            if let character = component.first {
                initials.append(character)
            }
        }
        
        return initials
    }
}
