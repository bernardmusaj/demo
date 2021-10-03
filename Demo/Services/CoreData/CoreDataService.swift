//
//  CoreDataService.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Demo")
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error as NSError? {
                fatalError("Unresolved error \(err), \(err.userInfo)")
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
