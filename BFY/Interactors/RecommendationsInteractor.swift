//
//  RecommendationsInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation
import Hermes

final class RecommendationsInteractor: BaseInteractor {
    
    func recommendations(
        success: @escaping (APIResponse<ContentResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getRecommendations(
            path: "/content",
            responseType: APIResponse<ContentResponse>.self,
            success: success,
            failure: failure
        )
    }
    
    private func getRecommendations<T>(
        path: String,
        responseType: T.Type,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        let request = HermesRequest(
            method: .get,
            path: path,
            params: [
                "count": "15",
                "from": "\(Int.random(in: 0..<7))" // 22 books in db
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
