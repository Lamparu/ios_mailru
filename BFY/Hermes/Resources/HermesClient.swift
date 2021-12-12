



import Foundation

public final class HermesClient {
    private let baseUrl: String
    
    private let headers: [String: String]
    
    private var standartHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "User-Agent": "BFY/1.0 iOS"
        ]
    }
    
    public init(with baseUrl: String, headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.headers = headers ?? [:]
    }
    
    private func createRequest(with request: HermesRequest) -> URLRequest? {
        let urlString = baseUrl + request.path
        var components = URLComponents(string: urlString)
        components?.queryItems = request.params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B") else {
            return nil
        }
        components?.percentEncodedQuery = encodedQuery
        guard let url = components?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        var httpHeaders = standartHeaders
        for (key, value) in headers {
            httpHeaders.updateValue(value, forKey: key)
        }
        for (key, value) in request.headers {
            httpHeaders.updateValue(value, forKey: key)
        }
        urlRequest.allHTTPHeaderFields = httpHeaders
        return urlRequest
    }
    
    public func run(with request: HermesRequest) {
        guard let urlRequest = createRequest(with: request) else {
            request.errorHandler?(HermesError.invalidUrl)
            return
        }
        
        let failure = { (error: Error) in
            DispatchQueue.main.async {
                request.errorHandler?(error)
            }
        }
        let success = { (response: HermesResponse) in
            DispatchQueue.main.async {
                request.successHandler?(response)
            }
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                failure(error)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                failure(HermesError.invalidCode)
                return
            }
            guard let data = data else {
                failure(HermesError.emptyData)
                return
            }
            success(.init(data: .init(with: data), code: response.statusCode, headers: response.allHeaderFields))
        }
        task.resume()
    }
}
