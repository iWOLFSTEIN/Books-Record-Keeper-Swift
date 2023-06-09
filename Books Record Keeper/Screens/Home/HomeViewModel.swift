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
        
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        CoreDataDatabase.shared.retrieveAllRecords(ofEntity: .books, sortDescriptor: sortDescriptor, completion: { result in
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
    
    func deleteBookRecord(withName name: String) {
        CoreDataDatabase.shared.deleteRecord(ofEntity: .books, completion: { fetchRequest in
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        })
    }
}
