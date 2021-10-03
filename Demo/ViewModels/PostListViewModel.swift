//
//  PostListViewModel.swift
//  Demo
//
//  Created by Bernard Musaj on 10.4.21.
//

import Foundation

class PostListViewModel {
    var reloadTable: (()->())?
    var showAlert: (()->())?
    var updateLoadingStatus: (()->())?
    
    private var posts: [Post] = [Post]() {
        didSet {
            self.reloadTable?()
        }
    }
    
    var selectedPost: Post?
    
    var numberOfPosts: Int {
        return posts.count
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    func clearCache() {
        self.posts = [Post]()
    }
    
    func getPosts() {
        
        self.isLoading = true
        
        PostService.shared.getAllPosts { [weak self] (retrievedPosts, error) in
            if error != nil {
                Log.error("Something went wrong: \(error!.localizedDescription)")
            } else {
                self?.posts = retrievedPosts!
            }
            self?.isLoading = false
        }
    }
    
    // MARK: - Single Post data
    func getPost( at indexPath: IndexPath ) -> Post {
        return posts[indexPath.row]
    }
}
