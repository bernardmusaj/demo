//
//  PostDetailsViewModel.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import Foundation

class PostDetailsViewModel {
    var reloadTable:(()->())?
    var updateCommentsLoadingStatus: (()->())?
    var updateUserLoadingStatus:(()->())?
    var setupPostUserDetailsUI:(()->())?
    var post: Post
    
    init(post selectedPost: Post) {
        post = selectedPost
    }
    private var comments: [Comment] = [Comment]() {
        didSet {
            self.reloadTable?()
        }
    }
    
    var user: User? {
        didSet {
            self.updateUserLoadingStatus?()
        }
    }
    
    var numberOfComments: Int {
        return comments.count
    }
    
    var isCommentSectionLoading: Bool = false {
        didSet {
            self.updateCommentsLoadingStatus?()
        }
    }
    
    var isUserLoading: Bool = false {
        didSet {
            self.updateUserLoadingStatus?()
            self.setupPostUserDetailsUI?()
        }
    }
    
    func getPostTitle() -> String {
        return post.title
    }
    
    func getPostBody() -> String {
        return post.body
    }
    
    func getPostUserUsername() -> String {
        return user?.username ?? "-"
    }
    
    func getPostUserFullname() -> String {
        return "(\(user?.name ?? "-"))"
    }
    
    func getComments() {
        
        self.isCommentSectionLoading = true
        
        PostService.shared.getPostComments(postId: post.id) { [weak self] (retrievedComments, error) in
            if error != nil {
                Log.error("Something went wrong: \(error!.localizedDescription)")
            } else {
                self?.comments = retrievedComments!
            }
            self?.isCommentSectionLoading = false
        }
    }
    
    func getUser() {
        self.isUserLoading = true
        
        PostService.shared.getPostUser(userId: post.userId) { [weak self] (user, error) in
            if error != nil {
                Log.error("Something went wrong: \(error!.localizedDescription)")
            } else {
                self?.user = user!
            }
            self?.isUserLoading = false
        }
    }
    
    // MARK: - Single Comment data
    func getComment( at indexPath: IndexPath ) -> Comment {
        return comments[indexPath.row]
    }
}
