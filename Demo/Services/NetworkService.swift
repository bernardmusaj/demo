//
//  NetworkService.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//

import Foundation

class NetworkService {
    
    static let sharedInstance = NetworkService()
    private let session =  URLSession.shared
    private init() {}
    
    public func getPosts(completion: @escaping([Post]?, Error?) -> Void) {
        let url = URL(string: postsUrl)!
        
        Log.debug("Requesting Posts")
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            //Log.debug("Data: \(String(describing: data))")
            //Log.debug("Response: \(String(describing: response))")
            //Log.debug("Error: \(String(describing: error))")
            
            if error != nil {
                //Handle error
                Log.error("Something went wrong!")
                completion(nil, error)
                return
            }
            
            guard let httpRes = response as? HTTPURLResponse, (200...299).contains(httpRes.statusCode) else {
                //Handle http error
                Log.error("Http error response")
                completion(nil, error)
                return
            }
            
            //Process reponse
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data!)
                Log.debug("Got \(posts.count) Posts")
                
                //Insert posts to CoreData
                posts.forEach { (post) in
                    let managedPost = ManagedPost.newEntity()
                    
                    managedPost.id = Int64(post.id)
                    managedPost.title = post.title
                    managedPost.body = post.body
                    managedPost.userId = Int64(post.userId)
                    
                    _ = managedPost.save()
                }
                completion(posts, nil)
            } catch {
                Log.error("JSON error: \(error.localizedDescription)")
                completion(nil, error)
            }
        })

        task.resume()
    }
    
    public func getComments(postId: Int, completion: @escaping([Comment]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(string: commentsUrl)!
        urlComponents.queryItems = [URLQueryItem(name: "postId", value: postId.description)]
        
        Log.debug("Requesting Comments for Post: \(postId)")
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!, completionHandler: { (data, response, error) in
            //Log.debug("Data: \(String(describing: data))")
            //Log.debug("Response: \(String(describing: response))")
            //Log.debug("Error: \(String(describing: error))")
            
            if error != nil {
                //Handle error
                Log.error("Something went wrong!")
                completion(nil, error)
                return
            }
            
            guard let httpRes = response as? HTTPURLResponse, (200...299).contains(httpRes.statusCode) else {
                //Handle http error
                Log.error("Http error response")
                completion(nil, error)
                return
            }
            
            //Process reponse
            do {
                let comments = try JSONDecoder().decode([Comment].self, from: data!)
                Log.debug("Got \(comments.count) Comments for post: \(postId)")
                
                //Insert posts to CoreData
                comments.forEach { (comment) in
                    let managedComment = ManagedComment.newEntity()
                    
                    managedComment.id = Int64(comment.id)
                    managedComment.postId = Int64(comment.postId)
                    managedComment.userName = comment.userName
                    managedComment.email = comment.email
                    managedComment.commentBody = comment.commentBody
                    
                    _ = managedComment.save()
                }
                
                completion(comments, nil)
            } catch {
                Log.error("JSON error: \(error.localizedDescription)")
                completion(nil, error)
            }
        })
        
        task.resume()
        
    }
    
    public func getUser(userId: Int, completion: @escaping(User?, Error?) -> Void) {
        let url = URL(string: userUrl + "/\(userId)")!
        
        Log.debug("Requesting User: \(userId)")
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            //Log.debug("Data: \(String(describing: data))")
            //Log.debug("Response: \(String(describing: response))")
            //Log.debug("Error: \(String(describing: error))")
            
            if error != nil {
                //Handle error
                Log.error("Something went wrong!")
                completion(nil, error)
                return
            }
            
            guard let httpRes = response as? HTTPURLResponse, (200...299).contains(httpRes.statusCode) else {
                //Handle http error
                Log.error("Http error response")
                completion(nil, error)
                return
            }
            
            //Process reponse
            do {
                let user = try JSONDecoder().decode(User.self, from: data!)
                Log.debug("Got User: \(user.name)")
                
                //Insert user to CoreData
                let managedUser = ManagedUser.newEntity()
                
                managedUser.id = Int64(user.id)
                managedUser.name = user.name
                managedUser.username = user.username
                managedUser.email = user.email
                managedUser.phone = user.phone
                managedUser.website = user.website
                
                _ = managedUser.save()
                
                completion(user, nil)
            } catch {
                Log.error("JSON error: \(error.localizedDescription)")
                completion(nil, error)
            }
        })

        task.resume()
    }
}
