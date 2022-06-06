public struct StandardError: Error {
    public let code: String
    public let origin: String
    
    public let rawResponse: RawResponse
    
    public init(code: String, origin: String, rawResponse: RawResponse) {
        self.code = code
        self.origin = origin
        self.rawResponse = rawResponse
    }
}
