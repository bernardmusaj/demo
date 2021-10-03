//
//  ManagedPost+CoreDataClass.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//
//

import Foundation
import CoreData

@objc(ManagedPost)
public class ManagedPost: NSManagedObject, ManagedObjectProtocol {
    
    internal typealias this = ManagedPost
    
    static func newEntity() -> ManagedPost {
        return NSEntityDescription.insertNewObject(forEntityName: this.entityName, into: this.context) as! ManagedPost
    }
    
    static func request() -> NSFetchRequest<ManagedPost> {
        return this.fetchRequest()
    }
    
    static func fetch(_ withPredicate: NSPredicate?) -> [ManagedPost] {
        let fetchRequest = request()
        fetchRequest.predicate = withPredicate
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            Log.debug("Error while fetching Posts form Core Data")
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
            Log.debug("All Posts were deleted from CoreData.")
            return true
        } catch {
            Log.debug("Failed to delete all Posts from CoreData.")
            return false
        }
    }
}
