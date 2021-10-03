//
//  PostService.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import Foundation

class PostService {
    static let shared = PostService()
    private init () {}
    
    func getAllPosts(completion: @escaping([Post]?, Error?) -> Void) {
        let coreDataPosts = ManagedPost.fetch(nil)
        
        if (coreDataPosts.count == 0) {
            NetworkService.sharedInstance.getPosts { (retrievedPosts, error) in
                if error != nil {
                    Log.error("Something went wrong: \(error!.localizedDescription)")
                } else {
                    sleep(1) //Just to delay the request a bit so we can see the indicator
                    completion(retrievedPosts, nil)
                }
            }
        } else {
            let posts = coreDataPosts.map { (managedPost) -> Post in
                return Post(managedPost: managedPost)
            }
            Log.debug("Loaded from CoreData, Posts: \(posts.count)")
            completion(posts, nil)
        }
    }
    
    func getPostUser(userId: Int, completion: @escaping(User?, Error?) -> Void) {
        let predicate = NSPredicate(format: "id == %@", NSNumber(integerLiteral: userId))
        let coreDataUser = ManagedUser.fetch(predicate).first
        
        if (coreDataUser != nil) {
            Log.debug("Loaded from CoreData, User: \(coreDataUser!.name!) (\(coreDataUser!.id))")
            completion(User(managedUser: coreDataUser!), nil)
        } else {
            NetworkService.sharedInstance.getUser(userId: userId) { (user, error) in
                if error != nil {
                    Log.error("Something went wrong: \(error!.localizedDescription)")
                } else {
                    sleep(1) //Just to delay the request a bit so we can see the indicator
                    completion(user, nil)
                }
            }
        }
    }
    
    func getPostComments(postId: Int, completion: @escaping([Comment]?, Error?) -> Void) {
        let predicate = NSPredicate(format: "postId == %@", NSNumber(integerLiteral: postId))
        let coreDataPostComments = ManagedComment.fetch(predicate)
        
        if (coreDataPostComments.count == 0) {
            NetworkService.sharedInstance.getComments(postId: postId) { (comments, error) in
                if error != nil {
                    Log.error("Something went wrong: \(error!.localizedDescription)")
                } else {
                    sleep(1) //Just to delay the request a bit so we can see the indicator
                    completion(comments, nil)
                }
            }
        } else {
            let comments = coreDataPostComments.map { (coreDataComment) -> Comment in
                return Comment(managedComment: coreDataComment)
            }
            Log.debug("Loaded from CoreData, Comments: \(comments.count) , for Post: (\(postId))")
            completion(comments, nil)
        }
    }
}
