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
    
    convenience init(from book: Book) {
        self.init(
            id: book.id,
            title: book.title,
            authors: book.authors,
            image: book.image
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
