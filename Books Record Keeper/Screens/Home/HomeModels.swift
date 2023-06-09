//
//  HomeModels.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 09/06/2023.
//

import Foundation

enum DatabaseEntities: String {
    case books = "Books"
}

struct Book {
    let name: String
    let creationDate: String
    
    init(name: String, creationDate: Date) {
        self.name = name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        self.creationDate = dateFormatter.string(from: creationDate)
    }
}

