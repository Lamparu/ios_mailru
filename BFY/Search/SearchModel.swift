//
//  SearchModel.swift
//  BFY
//
//  Created by Анастасия Московчук on 13.12.2021.
//

import Foundation

struct SearchResult {
    let books: [BookInfo]
    
    init(books: [BookInfo]) {
        self.books = books
    }
}

final class SearchModel: NSObject {
    private let interactor = SearchInteractor()
    private let from = 0
    private let count = 1

    func search(query: String, success: @escaping (SearchResult) -> Void, failure: @escaping (String) -> Void) {
        interactor.search(from: from, count: count, query: query) { responce in
            print("resp.body is", responce.body)
            success(self.trasformate(resp: responce.body ?? nil))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }
    
    private func trasformate(resp: SearchResponse?) -> SearchResult {
        guard let resp = resp else {
            return SearchResult(books: [])
        }
        print("resp.result is", resp.result)
        let books = resp.result.books.items.map { BooksBody -> BookInfo in
            BookInfo(from: BooksBody)
        }
        let searchResult = SearchResult(books: books)
        return searchResult
    }

//    private func trasformate(resp: SearchResponse?) -> SearchResult {
//        guard let resp = resp else {
//            return SearchResult(books: [])
//        }
//        let books = resp.result.books.items.map
//        }
//        let searchResult = SearchResult(books: books)
//        return searchResult
//    }
}
