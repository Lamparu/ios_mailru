//
//  ContentInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation
import Hermes

struct ContentResponse: Decodable {
    let movies: [APIMovie]
    let tvshows: [APITVShow]
}

struct ContentFilters: Decodable {
    var year: Int? = nil
    var genre: Int? = nil
    var country: Int? = nil
    var actor: Int? = nil
    var director: Int? = nil
    var is_free: Bool? = nil
}

final class ContentInteractor: BaseInteractor {
    
    func filtredContent(
        from: Int,
        count: Int,
        filters: ContentFilters,
        success: @escaping (APIResponse<ContentResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getContent(
            path: "/content",
            responseType: APIResponse<ContentResponse>.self,
            from: from,
            count: count,
            filters: filters,
            success: success,
            failure: failure
        )
    }
    
    func previewContent(
        success: @escaping (APIResponse<ContentResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let count = 5
        let from = Int.random(in: 0..<17) // 22 movies and tvshows in db
        getContent(
            path: "/content",
            responseType: APIResponse<ContentResponse>.self,
            from: from,
            count: count,
            filters: ContentFilters(),
            success: success,
            failure: failure
        )
    }
    
    private func getContent<T>(
        path: String,
        responseType: T.Type,
        from: Int,
        count: Int,
        filters: ContentFilters,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        var params = [
            "count": "\(count)",
            "from": "\(from)"
        ]
        
        // TODO make via iterations
        if let year = filters.year {
            params["year"] = "\(year)"
        }
        if let genre = filters.genre {
            params["genre"] = "\(genre)"
        }
        if let country = filters.country {
            params["country"] = "\(country)"
        }
        if let actor = filters.actor {
            params["actor"] = "\(actor)"
        }
        if let director = filters.director {
            params["director"] = "\(director)"
        }
        if let is_free = filters.is_free {
            params["is_free"] = "\(is_free)"
        }
        
        let request = HermesRequest(
            method: .get,
            path: path,
            params: params
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
