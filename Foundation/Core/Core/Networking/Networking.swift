public protocol Networking {
    func perform<Response: Decodable>(request: Requestable, result: @escaping (Result<Response, StandardError>) -> Void)
}
