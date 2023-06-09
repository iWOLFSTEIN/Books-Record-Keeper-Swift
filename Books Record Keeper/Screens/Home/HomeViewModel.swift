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
    
    func initNSManagedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    func createRecord(withName name: String, inEntity entity: DatabaseEntities) {
        guard let managedContext = initNSManagedObjectContext() else { return }
        guard let entityInstance = NSEntityDescription.entity(forEntityName: entity.rawValue, in: managedContext) else { return }
        
        let entity = NSManagedObject(entity: entityInstance, insertInto: managedContext)
        books.setValue(name, forKey: "name")
        books.setValue(Date(), forKey: "creationDate")
        
        do {
            try managedContext.save()
            print("Record Saved!")
        } catch _ as NSError {
            
        }
    }
    
    func createBookRecord(withName name: String) {
        
    }
    
    func retrieveAllRecords(ofEntity entity: DatabaseEntities, completion: @escaping (_ : [NSFetchRequestResult]) -> Void)  {
        guard let managedContext = initNSManagedObjectContext() else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            completion(result)
        } catch {
            completion([])
        }
    }
    
    func retrieveAllBooksRecords() -> [Book] {
        var books: [Book] = []
        retrieveAllRecords(ofEntity: .books, completion: { result in
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
