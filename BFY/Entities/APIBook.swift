//
//  APIBook.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation

struct APIBook: Decodable {
    let id: Int
    let name: String
    let reading_now: Bool
    let my_book: Bool
    let images: String
    let authors: [APIAuthor]?
}
