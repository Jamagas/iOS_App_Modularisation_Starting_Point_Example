import Core
import SwiftUI

final class NetworkingProvider: Networking {
    
    private let requestSerializer = RequestSerializer()
    
    func perform<Response: Decodable>(request: Requestable, result: @escaping (Result<Response, Core.StandardError>) -> Void) {
        let serializedRequest = requestSerializer.serialize(request)
        URLSession.shared.dataTask(with: serializedRequest) { data, response, error in
            let validationResult = ResponseValidator().validate(data, response, error)
            switch validationResult {
            case let .valid(data):
                do {
                    let model = try JSONDecoder().decode(Response.self, from: data)
                    result(.success(model))
                } catch let decodingError {
                    let rawResponse = Core.RawResponse(response: response, data: data, error: decodingError)
                    let standardError = StandardError(code: "-200", origin: "JSONDecoder", rawResponse: rawResponse)
                    result(.failure(standardError))
                }
            case let .invalid(error):
                result(.failure(error))
            }
        }.resume()
    }
}

private final class RequestSerializer {
    
    func serialize(_ inputRequest: Requestable) -> URLRequest {
        // TODO: Proper serialization shuold be done instead of stub
        let url = URL(string: "www.example.com")!
        let request = URLRequest(url: url)
        return request
    }
}

private final class ResponseValidator {
    enum Result {
        case valid(Data)
        case invalid(StandardError)
    }
    
    func validate(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result {
        let origin = "URLSession"
        let rawResponse = Core.RawResponse(response: response, data: data, error: error)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .invalid(StandardError(code: "-100", origin: origin, rawResponse: rawResponse))
        }
        
        let expectedStatusCodes = 200...299
        guard expectedStatusCodes.contains(httpResponse.statusCode) else {
            return .invalid(StandardError(code: "-101", origin: origin, rawResponse: rawResponse))
        }
        
        guard let data = data, !data.isEmpty else {
            return .invalid(StandardError(code: "-102", origin: origin, rawResponse: rawResponse))
        }
        
        return .valid(data)
    }
}
