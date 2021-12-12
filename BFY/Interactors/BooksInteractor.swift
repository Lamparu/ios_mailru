//
//  FilmsInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation
import Hermes

// TODO: split this interactor to MovieInteractor and TVShowInteractor
final class BooksInteractor: BaseInteractor {
    
    struct MoviesResponse: Decodable {
        let movies: [APIMovie]
    }
    
    func topMovies(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<MoviesResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/movies/top",
            responseType: APIResponse<MoviesResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func latestMovies(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<MoviesResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/movies/latest",
            responseType: APIResponse<MoviesResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func previewMovies(
        success: @escaping (APIResponse<MoviesResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let count = 5
        let from = Int.random(in: 0..<14) // 19 movies in db
        getMoviesForTop(
            path: "/movies",
            responseType: APIResponse<MoviesResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    struct TVShowResponse: Decodable {
        let tvshows: [APITVShow]
    }
    
    func topTVShows(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<TVShowResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/tvshows/top",
            responseType: APIResponse<TVShowResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func latestTVShows(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<TVShowResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/tvshows/latest",
            responseType: APIResponse<TVShowResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func previewTVShows(
        success: @escaping (APIResponse<TVShowResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let count = 3
        let from = 0 // 3 movies and tvshows in db
        getMoviesForTop(
            path: "/tvshows",
            responseType: APIResponse<TVShowResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    private func getMoviesForTop<T>(
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
    
    func moviesByGenre(
        from: Int,
        count: Int,
        genre: Int,
        success: @escaping (APIResponse<MoviesResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getContetntByGenre(
            path: "/movies",
            responseType: APIResponse<MoviesResponse>.self,
            from: from,
            count: count,
            genre: genre,
            success: success,
            failure: failure
        )
    }
    
    func tvshowsByGenre(
        from: Int,
        count: Int,
        genre: Int,
        success: @escaping (APIResponse<TVShowResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getContetntByGenre(
            path: "/tvshows",
            responseType: APIResponse<TVShowResponse>.self,
            from: from,
            count: count,
            genre: genre,
            success: success,
            failure: failure
        )
    }
    
    private func getContetntByGenre<T>(
        path: String,
        responseType: T.Type,
        from: Int,
        count: Int,
        genre: Int,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        let params = [
            "count": "\(count)",
            "from": "\(from)",
            "genre": "\(genre)"
        ]
        
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
