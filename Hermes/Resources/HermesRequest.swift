



import Foundation

public struct HermesResponse {
    public let data: HermesData // json
    public let code: Int // код ответа
    public let headers: [AnyHashable: Any] // хедеры ответа
}

public final class HermesRequest {
    public var successHandler: ((HermesResponse) -> Void)?
    public var errorHandler: ((Error) -> Void)?
    
    let method: HermesMethod
    let path: String
    let body: Data?
    let headers: [String: String]
    let params: [String: String]
    
    public init(method: HermesMethod, path: String, body: Data? = nil, headers: [String: String]? = nil, params: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.body = body
        self.headers = headers ?? [:]
        self.params = params ?? [:]
    }
}
