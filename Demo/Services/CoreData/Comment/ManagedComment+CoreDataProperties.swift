//
//  ManagedComment+CoreDataProperties.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//
//

import Foundation
import CoreData


extension ManagedComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedComment> {
        return NSFetchRequest<ManagedComment>(entityName: "ManagedComment")
    }

    @NSManaged public var id: Int64
    @NSManaged public var postId: Int64
    @NSManaged public var userName: String?
    @NSManaged public var email: String?
    @NSManaged public var commentBody: String?

}
