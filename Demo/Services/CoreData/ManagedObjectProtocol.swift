//
//  ManagedObjectProtocol.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//

import Foundation
import CoreData

protocol ManagedObjectProtocol {
    associatedtype this: NSManagedObject
    static var context: NSManagedObjectContext {get}
    static func newEntity() -> this
    static func request() -> NSFetchRequest<this>
    static func fetch(_ withPredicate: NSPredicate?) -> [this]
    static func deleteAll() -> Bool
    func delete() -> Bool
    func save() -> Bool
}

//MARK: Get entity name for any ManagedObject
extension NSManagedObject {
    static var entityName: String {
        return NSStringFromClass(self as AnyClass)
    }
}
