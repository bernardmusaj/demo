//
//  ManagedPost+CoreDataProperties.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//
//

import Foundation
import CoreData


extension ManagedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedPost> {
        return NSFetchRequest<ManagedPost>(entityName: "ManagedPost")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64
}
