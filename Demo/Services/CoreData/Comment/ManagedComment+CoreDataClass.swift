//
//  ManagedComment+CoreDataClass.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//
//

import Foundation
import CoreData

@objc(ManagedComment)
public class ManagedComment: NSManagedObject, ManagedObjectProtocol {
    
    typealias this = ManagedComment
    
    static func newEntity() -> ManagedComment {
        return NSEntityDescription.insertNewObject(forEntityName: this.entityName, into: this.context) as! ManagedComment
    }
    
    static func request() -> NSFetchRequest<ManagedComment> {
        return this.fetchRequest()
    }
    
    static func fetch(_ withPredicate: NSPredicate?) -> [ManagedComment] {
        let fetchRequest = request()
        fetchRequest.predicate = withPredicate
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            Log.debug("Error while fetching Comments form Core Data")
            return []
        }
    }
    
    static func deleteAll() -> Bool {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request() as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
            Log.debug("All Comments were deleted from CoreData.")
            return true
        } catch {
            Log.debug("Failed to delete all Comments from CoreData.")
            return false
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

}
