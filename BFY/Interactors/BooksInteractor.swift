//
//  FilmsInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation

// TODO: split this interactor to MovieInteractor and TVShowInteractor
final class BooksInteractor: BaseInteractor {
    
    struct BooksResponse: Decodable {
        let movies: [APIBook]
    }
    
    func topBooks(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<BooksResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getBooksForTop(
            path: "/movies/top",
            responseType: APIResponse<BooksResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func latestBooks(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<BooksResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getBooksForTop(
            path: "/movies/latest",
            responseType: APIResponse<BooksResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func previewBooks(
        success: @escaping (APIResponse<BooksResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let count = 5
        let from = Int.random(in: 0..<14) // 19 movies in db
        getBooksForTop(
            path: "/movies",
            responseType: APIResponse<BooksResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    private func getBooksForTop<T>(
        path: String,
        responseType: T.Type,
        from: Int,
        count: Int,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable{
        let request = HermesRequest(
            method: .get,
            path: path, body: nil,
            headers: nil,
            params: [
                "count": "\(count)",
                "from": "\(from)"
            ]
        )
        request.successHandler = { response in
            guard let data = response.data.decode(type: T.self) else {
                failure(InteractorError.emptyData)
                return
            }
            success(data)
        }
        
        request.errorHandler = { error in
            failure(error)
        }
        
        client.run(with: request)
    }
}
