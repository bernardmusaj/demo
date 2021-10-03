//
//  Post.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//

import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
}

extension Post {
    init(managedPost: ManagedPost) {
        id = Int(managedPost.id)
        userId = Int(managedPost.userId)
        title = managedPost.title!
        body = managedPost.body!
    }
}
