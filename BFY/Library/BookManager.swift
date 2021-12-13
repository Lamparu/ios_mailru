//
//  BookManager.swift
//  BFY
//
//  Created by Анастасия Московчук on 16.11.2021.
//

import Foundation

final class BookInfo: Equatable {
    
    let id: String
    let title: String
    let authors: [String]
    let image: String
    
//    func changeStruct(book: APIBook) -> Book {
//        let id: String
//        let title: String
//        let authors: [String]
//        let image: String
//
//        id = book.items[0].id
//        title = book.items[0].volumeInfo.title
//        authors = book.items[0].volumeInfo.authors
//        image = book.items[0].volumeInfo.imageLinks.smallThumbnail
//        let bookNew = Book(id: id, title: title, authors: authors, image: image)
//        return bookNew
//    }
    
    convenience init(from book: APIBook) {
        self.init(
            id: book.items[0].id,
            title: book.items[0].volumeInfo.title,
            authors: book.items[0].volumeInfo.authors,
            image: book.items[0].volumeInfo.imageLinks.smallThumbnail
        )
    }
    
    init(id: String, title: String, authors: [String], image: String) {
        self.id = id
        self.title = title
        self.authors = authors
        self.image = ""
    }
    
    static func ==(lhs: BookInfo, rhs: BookInfo) -> Bool {
        return lhs.id == rhs.id
    }
}
