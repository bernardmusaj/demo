//
//  Comment.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import Foundation

struct Comment: Codable {
    
    let id: Int
    let postId: Int
    let userName: String
    let email: String
    let commentBody: String
    
    private enum CodingKeys: String, CodingKey {
        case id, postId, email
        case userName = "name"
        case commentBody = "body"
    }
    
    init(managedComment: ManagedComment) {
        id = Int(managedComment.id)
        postId = Int(managedComment.postId)
        userName = managedComment.userName!
        email = managedComment.email!
        commentBody = managedComment.commentBody!
    }
}
