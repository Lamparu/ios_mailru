//
//  FavoritesInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation
import Hermes

final class FavoritesInteractor: BaseInteractor {
    
    private struct FavoriteRequest: Encodable {
        let content_id: Int
    }
    
    func add(
        contentId: Int,
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void
    ) {
        guard let data = try? encoder.encode(FavoriteRequest(content_id: contentId)) else {
            failure(InteractorError.invalidEncode)
            return
        }
        let request = HermesRequest(method: .post, path: "/favourites", body: data, headers: ["X-Csrf-Token": CSRFStorage.shared.token ?? ""])
        request.successHandler = { _ in
            success()
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
    
    func delete(
        contentId: Int,
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void
    ) {
        guard let data = try? encoder.encode(FavoriteRequest(content_id: contentId)) else {
            failure(InteractorError.invalidEncode)
            return
        }
        let request = HermesRequest(method: .delete, path: "/favourites", body: data, headers: ["X-Csrf-Token": CSRFStorage.shared.token ?? ""])
        request.successHandler = { _ in
            success()
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
}
