/// Request method used in `Requestable` protocol  to form an API request
public enum RequestMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

/// Protocol used to make a request
public protocol Requestable: Encodable {

    /// Method used in requesst
    var method: RequestMethod { get }
    // Path to the endpoint
    var path: String { get }
    /// Headers used in the request
    var headers: [String: String] { get }
    /// Query used in the request
    var query: [String: [String]] { get }

    func encode(using encoder: JSONEncoder) throws -> Data
}

public extension Requestable {

    var headers: [String: String] {
        [:]
    }

    var query: [String: [String]] {
        guard method == .get || method  == .delete,
              let data = try? JSONEncoder().encode(self),
              let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }

        return object.mapValues { value in
            switch value {
            case let value as [String]:
                return value
            case let value as String:
                return [value]
            default:
                return []
            }
        }
    }

    func encode(using encoder: JSONEncoder) throws -> Data {
        try encoder.encode(self)
    }
}
