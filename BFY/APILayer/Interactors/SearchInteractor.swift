import Foundation

struct SearchResponse: Codable {
    let kind: String
    let totalItems: Int
    let items: [BooksBody]
}

final class SearchInteractor: BaseInteractor {
    
    func search(
        from: Int,
        count: Int,
        query: String,
        success: @escaping (SearchResponse) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getSearchResult(
            path: "/volumes",
            responseType: APIResponse<SearchResponse>.self,
            from: from,
            count: count,
            query: query,
            success: success,
            failure: failure
        )
    }
    
    private func getSearchResult<T>(
        path: String,
        responseType: T.Type,
        from: Int,
        count: Int,
        query: String,
        success: @escaping (SearchResponse) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        let request = HermesRequest(
            method: .get,
            path: path,
            params: [
                "q": query,
                "count": "\(count)",
                "from": "\(from)"
            ]
        )
        request.successHandler = { response in
            var data: SearchResponse
            do {
                let decoder = JSONDecoder()
                data = try decoder.decode(SearchResponse.self, from: response.data.data)
            } catch let error {
                failure(error)
                return
            }
            success(data)

//            let stat = try! decoder.decode(SearchResponse.self, from: response.data.data)
//            guard let data = response.data.decode(type: T.self) else {
//                failure(InteractorError.emptyData)
//                return
//            }
//            success(data)
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
}
