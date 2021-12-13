//
//  APIResult.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

import Foundation

struct APIResult: Decodable {
    let books: [APIBook]
//    let authors: [APIAuthor]
}
