//
//  FilmsInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

//import Foundation
//
//// id; в volumeInfo: title & authors, который является массивом; в imageLinks: smallThumbnail
//
//final class BooksInteractor: BaseInteractor {
//    
//    struct BooksResponse: Decodable {
//        let books: [APIBook]
//    }
//    
////    func searchBooks(
////        from: Int,
////        count: Int,
////        success: @escaping (APIResponse<BooksResponse>) -> Void,
////        failure: @escaping (Error) -> Void
////    ) {
////        getBooksForTop(
////            path: "/volumes",
////            data: 
////            responseType: APIResponse<BooksResponse>.self,
////            from: from,
////            count: count,
////            success: success,
////            failure: failure
////        )
////    }
//    
//    func previewBooks(
//        query: String,
//        from: Int,
//        count: Int,
//        success: @escaping (APIResponse<BooksResponse>) -> Void,
//        failure: @escaping (Error) -> Void
//    ) {
//        let count = 5
//        let from = Int.random(in: 0..<14)
//        getBooksForTop(
//            path: "/volumes",
//            responseType: APIResponse<BooksResponse>.self,
//            query: query,
//            from: from,
//            count: count,
//            success: success,
//            failure: failure
//        )
//    }
//    
//    private func getBooksForTop<T>(
//        path: String,
//        responseType: T.Type,
//        query: String,
//        from: Int,
//        count: Int,
//        success: @escaping (T) -> Void,
//        failure: @escaping (Error) -> Void
//    ) where T: Decodable{
//        let request = HermesRequest(
//            method: .get,
//            path: path,
//            body: nil,
//            headers: nil,
//            params: [
//                "count": "\(count)",
//                "from": "\(from)"
//            ]
//        )
//        request.successHandler = { response in
//            guard let data = response.data.decode(type: T.self) else {
//                failure(InteractorError.emptyData)
//                return
//            }
//            success(data)
//        }
//        
//        request.errorHandler = { error in
//            failure(error)
//        }
//        
//        client.run(with: request)
//    }
//    
////        func topBooks(
////            from: Int,
////            count: Int,
////            success: @escaping (APIResponse<BooksResponse>) -> Void,
////            failure: @escaping (Error) -> Void
////        ) {
////            getBooksForTop(
////                path: "/books/top",
////                responseType: APIResponse<BooksResponse>.self,
////                from: from,
////                count: count,
////                success: success,
////                failure: failure
////            )
////        }
////        
////        func latestBooks(
////            from: Int,
////            count: Int,
////            success: @escaping (APIResponse<BooksResponse>) -> Void,
////            failure: @escaping (Error) -> Void
////        ) {
////            getBooksForTop(
////                path: "/movies/latest",
////                responseType: APIResponse<BooksResponse>.self,
////                from: from,
////                count: count,
////                success: success,
////                failure: failure
////            )
////        }
//}
