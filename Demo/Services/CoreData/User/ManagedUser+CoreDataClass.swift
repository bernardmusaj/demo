//
//  ManagedUser+CoreDataClass.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//
//

import Foundation
import CoreData

@objc(ManagedUser)
public class ManagedUser: NSManagedObject, ManagedObjectProtocol {
    typealias this = ManagedUser
    
    static func newEntity() -> ManagedUser {
        return NSEntityDescription.insertNewObject(forEntityName: this.entityName, into: this.context) as! ManagedUser
    }
    
    static func request() -> NSFetchRequest<ManagedUser> {
        return this.fetchRequest()
    }
    
    static func fetch(_ withPredicate: NSPredicate?) -> [ManagedUser] {
        let fetchRequest = request()
        fetchRequest.predicate = withPredicate
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            Log.debug("Error while fetching Users form Core Data")
            return []
        }
    }
    
    func delete() -> Bool {
        this.context.delete(self)
        return save()
    }
    
    func save() -> Bool {
        do {
            try this.context.save()
            return true
        } catch {
            Log.debug("Could not save to Core Date, Error: \(error.localizedDescription)")
            return false
        }
    }

    static var context: NSManagedObjectContext {
        return CoreDataService.shared.mainContext
    }
    
    static func deleteAll() -> Bool {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request() as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
            Log.debug("All Users were deleted from CoreData.")
            return true
        } catch {
            Log.debug("Failed to delete all Users from CoreData.")
            return false
        }
    }
}
