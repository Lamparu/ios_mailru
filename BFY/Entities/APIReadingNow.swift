//
//  APIReadingNow.swift
//  BFY
//
//  Created by Анастасия Московчук on 12.12.2021.
//

import Foundation

struct APIReadingNow: Decodable {
    let books: [APIBook]
}
