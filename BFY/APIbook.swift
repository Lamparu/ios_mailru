//
//  APIBook.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation

struct APIImageLinks: Decodable {
    let smallThumbnail: String
    let thumbnail: String
}

struct APIVolumeInfo: Decodable {
    let title: String
    let authors: [String]
    let imageLinks: APIImageLinks
}

struct BooksBody: Decodable {
    let id: String
    let volumeInfo: APIVolumeInfo
}

struct APIBook: Decodable  {
    let items: [BooksBody]
}

//struct APIBook: Decodable {
//    // id; в volumeInfo: title & authors, который является массивом; в imageLinks: smallThumbnail
//    let id: Int
//    let name: String
//    let reading_now: Bool
//    let my_book: Bool
//    let images: String
//    let authors: [APIAuthor]?
//}
