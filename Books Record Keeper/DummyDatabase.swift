//
//  DummyDatabase.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import Foundation

class DummyDatabase {
    static let shared = DummyDatabase()
    private init () {}
    
    var books: [String] = []
    
    func addBook(withName name: String) {
        books.append(name)
    }
    
    func removeBook(withName name: String) {
        books.removeAll { $0 == name }
    }
}
