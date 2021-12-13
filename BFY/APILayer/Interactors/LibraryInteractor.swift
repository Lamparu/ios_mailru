//
//  MyListInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

//import Foundation
//
//struct LibraryResponse: Decodable {
//    let reading_now: APIReadingNow
//}
//
//final class LibraryInteractor: BaseInteractor {
//
//    func content(
//        success: @escaping (APIResponse<LibraryResponse>) -> Void,
//        failure: @escaping (Error) -> Void
//    ) {
//        let request = HermesRequest(method: .get, path: "/favourites")
//        request.successHandler = { response in
//            guard let data = response.data.decode(type: APIResponse<LibraryResponse>.self) else {
//                failure(InteractorError.emptyData)
//                return
//            }
//            success(data)
//        }
//        request.errorHandler = { error in
//            failure(error)
//        }
//        client.run(with: request)
//    }
//}
