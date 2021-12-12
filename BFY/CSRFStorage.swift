//
//  CSRFStorage.swift
//  BFY
//
//  Created by Анастасия Московчук on 12.12.2021.
//

import Foundation

final class CSRFStorage {
    static let shared = CSRFStorage()
    
    private let userDefaults = UserDefaults.standard
    private let key = "BFY.csrf"
    
    private init() {}
    
    var token: String? {
        get {
            userDefaults.string(forKey: key)
        }
        set {
            userDefaults.setValue(newValue, forKey: key)
        }
    }
}
