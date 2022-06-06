/// Raw response from URLSession
public struct RawResponse {
    public let response: URLResponse?
    public let data: Data?
    public let error: Error?
    
    public init(response: URLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.data = data
        self.error = error
    }
}
