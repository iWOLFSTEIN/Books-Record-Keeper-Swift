//
//  CoreDataDatabase.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 09/06/2023.
//

import CoreData
import Foundation
import UIKit

class CoreDataDatabase {
    static let shared = CoreDataDatabase()
    private init() {}
    
    func initNSManagedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    func createRecord(inEntity entity: DatabaseEntities, completion: @escaping (_ : NSManagedObject) -> Void) {
        guard let managedContext = initNSManagedObjectContext() else { return }
        guard let entityInstance = NSEntityDescription.entity(forEntityName: entity.rawValue, in: managedContext) else { return }
        
        let entity = NSManagedObject(entity: entityInstance, insertInto: managedContext)
        completion(entity)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func retrieveAllRecords(ofEntity entity: DatabaseEntities, sortDescriptor: NSSortDescriptor? = nil, completion: @escaping (_ : [NSFetchRequestResult]) -> Void)  {
        guard let managedContext = initNSManagedObjectContext() else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        
        if let sortDescriptor {
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            completion(result)
        } catch {
            completion([])
        }
    }
    
    func deleteRecord(ofEntity entity: DatabaseEntities, completion: @escaping (_ : NSFetchRequest<NSFetchRequestResult>) -> Void) {
        guard let managedContext = initNSManagedObjectContext() else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        
        completion(fetchRequest)
        
        do {
            let records = try managedContext.fetch(fetchRequest)
            for record in records {
                managedContext.delete(record as! NSManagedObject)
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
