import XcodeServer
import Foundation

extension Data {
    var hexString: String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Bundle {
    func decodeJson<T: Decodable>(_ resource: String, decoder: JSONDecoder = .init()) -> T? {
        guard let url = self.url(forResource: resource, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}

extension Server.ID {
    static let apple = "xcode.apple.com"
}

extension Bot.ID {
    static let bakeshopIOS = "bba9b6ff6d6f0899a63d1e347e040bb4"
    static let crazyMonkeyIOS = "ffe2a262684f526813c8865982004e72"
    static let dynumiteMacOS = "705d82e27dbb120dddc09af79100116b"
    static let mindsetIOS = "af6b157df3d9eafd03c8d2695a000cec"
    static let pocketBotIOS = "bba9b6ff6d6f0899a63d1e347e00ff15"
    static let pocketBotTvOS = "7165830f996e973601a81f0b2897b844"
    static let structuredIOS = "c50a58f76e7104f98942443df600c26c"
}

extension Integration.ID {
    static let bakeshop4 = "ce5f34cace5a2142835263cd2f210744"
    static let bakeshop3 = "ce5f34cace5a2142835263cd2f159f48"
    static let bakeshop2 = "ce5f34cace5a2142835263cd2f0a9f9d"
    static let bakeshop1 = "ce5f34cace5a2142835263cd2f00f906"
    static let dynumite24 = "2ce4a2fd2f57d53039edddc51e0009cf"
    static let dynumiteUnknown = "e70b54ebfe6bf1a17572855fa6000df2"
}

extension Issue.ID {
    static let dynumiteTrigger = "2ce4a2fd2f57d53039edddc51e002a26"
}

extension SourceControl.Commit.ID {
    static let dynumitePrefs = "6c50db852ea47eb1aacc525bb835c19e15bd71fd"
    static let dynumiteDependencies = "b86eed598f5be85d9af02b49c8f2d507f6c3a1e5"
    static let dynumiteVersionBump = "d01220669d0e9e7f486457bd332a6bea8106a6b0"
    static let dynumiteTests = "3bf16c66cd439fbeb7f82266a38083acb73b9d4f"
    static let dynumiteNotifications = "e92b7a358323dca3134815f5b24d0e4bf11974a6"
    static let dynumiteScheduler = "90df6b483105379c3c1f1adf0622f37b80859047"
    static let dynumiteAdditionalDependencies = "36cf580db1e9805052be94cfdcfb416eadfd40cf"
}
