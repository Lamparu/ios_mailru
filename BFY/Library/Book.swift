//
//  Book.swift
//  BFY
//
//  Created by Анастасия Московчук on 01.11.2021.
//

import Foundation

struct Book {
    let id: String
    let title: String
    let author: String
    let image: URL?
}
//
//func changeStruct(book: APIBook) -> Book {
//    let id: String
//    let title: String
//    let authors: [String]
//    let image: URL?
//    
//    id = book.items[0].id
//    title = book.items[0].volumeInfo.title
//    authors = book.items[0].volumeInfo.authors
//    image = URL(string: book.items[0].volumeInfo.imageLinks.smallThumbnail)
//    let bookNew = Book(id: id, title: title, authors: authors, image: image)
//    return bookNew
//}
