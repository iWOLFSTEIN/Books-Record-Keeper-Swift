//
//  HomeViewModel.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import CoreData
import Foundation
import UIKit

class HomeViewModel {

    func createBookRecord(withName name: String) {
        CoreDataDatabase.shared.createRecord(inEntity: .books, completion: { books in
            books.setValue(name, forKey: "name")
            books.setValue(Date(), forKey: "creationDate")
        })
    }
    
    func retrieveAllBooksRecords() -> [Book] {
        var books: [Book] = []
        CoreDataDatabase.shared.retrieveAllRecords(ofEntity: .books, completion: { result in
            for data in result as! [NSManagedObject] {
                if let name = data.value(forKey: "name") as? String,
                   let creationDate = data.value(forKey: "creationDate") as? Date {
                    let book = Book(name: name, creationDate: creationDate)
                    books.append(book)
                }
            }
        })
        return books
    }
}
