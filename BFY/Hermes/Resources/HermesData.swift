



import Foundation

public final class HermesData {
    private let data: Data
    
    private let decoder: JSONDecoder
    
    init(with data: Data) {
        self.data = data
        self.decoder = JSONDecoder()
    }
    
    public var dictionary: [String: Any]? {
        try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
    
    public func decode<T>(type: T.Type) -> T? where T: Decodable {
        try? decoder.decode(T.self, from: data)
    }
}
