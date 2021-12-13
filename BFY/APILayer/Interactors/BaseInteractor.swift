//
//  BaseInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 12.12.2021.
//
import Foundation

class BaseInteractor {
    let client: HermesClient
    
    let encoder: JSONEncoder
    
    convenience init() {
        self.init(base: "https://www.googleapis.com/books/v1")
    }
    
    init(base baseUrl: String) {
        client = HermesClient(with: baseUrl)
        encoder = JSONEncoder()
    }
}
