import Foundation

struct JSON {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }

    static var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }

    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }

    /// Uses `JSONSerialization` to create a dictionary representation of the provided `data`.
    static func dictionary(from data: Data?) -> [String : Any]? {
        guard let data = data else {
            return nil
        }

        let object: Any
        do {
            object = try JSONSerialization.jsonObject(with: data, options: .init())
        } catch {
            print(error)
            return nil
        }

        guard let dictionary = object as? [String : Any] else {
            return nil
        }

        return dictionary
    }

    /// Uses `JSONSerialization` to create an array representation of the provided `data`.
    static func array(from data: Data?) -> [[String: Any]]? {
        guard let data = data else {
            return nil
        }

        let object: Any
        do {
            object = try JSONSerialization.jsonObject(with: data, options: .init())
        } catch {
            print(error)
            return nil
        }

        guard let array = object as? [[String : Any]] else {
            return nil
        }

        return array
    }

    /// Uses `JSONSerialization` to create _any_ JSON object then re-serialize that
    /// object into a formatted JSON string.
    static func json(from data: Data?, pretty: Bool = false) -> String? {
        guard let data = data else {
            return nil
        }

        var options: JSONSerialization.WritingOptions = .init()
        if #available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
            options.insert(.sortedKeys)
        }
        if pretty {
            options.insert(.prettyPrinted)
        }

        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .init())
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: options)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }

    /// Uses `JSONSerialization` to create a data representation of the provided dictionary.
    static func data(from dictionary: [String : Any]?) -> Data? {
        guard let dictionary = dictionary else {
            return nil
        }

        var formattedDictionary: [String : Any] = dictionary

        for pair in dictionary {
            if let date = pair.value as? Date {
                formattedDictionary[pair.key] = dateFormatter.string(from: date)
            }
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: formattedDictionary, options: .init())
            return data
        } catch {
            print(error)
        }

        return nil
    }

    static func encode<T: Encodable>(_ object: T) -> Data? {
        let data: Data
        do {
            data = try jsonEncoder.encode(object)
        } catch {
            return nil
        }

        return data
    }
}

extension Encodable {
    /// Uses a `JSONEncoder` to encode the object, producing a `Data` representation.
    func asData() -> Data? {
        return JSON.encode(self)
    }

    /// A dictionary representation of the Encodable object.
    func asDictionary() -> [String : Any]? {
        return JSON.dictionary(from: asData())
    }

    /// An array representation of the Encodable object.
    func asArray() -> [[String : Any]]? {
        return JSON.array(from: asData())
    }

    /// A JSON string representation
    func asJSON() -> String? {
        return JSON.json(from: asData(), pretty: false)
    }

    /// A _pretty_ JSON representation
    func asPrettyJSON() -> String? {
        return JSON.json(from: asData(), pretty: true)
    }
}
