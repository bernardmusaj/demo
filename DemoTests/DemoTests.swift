//
//  DemoTests.swift
//  DemoTests
//
//  Created by Bernard Musaj on 9.4.21.
//

import XCTest
@testable import Demo

class DemoTests: XCTestCase {
    
    var postListViewModel: PostListViewModel!
    var postDetailsViewModel: PostDetailsViewModel!
    var post: Post!
    var user: User!
    
    var postListViewController: PostListViewController!
    var postDetailsViewController: PostDetailsViewController!
    var vc: UIViewController?
    
    override func setUpWithError() throws {
        post = Post(id: 1, userId: 2, title: "Test title", body: "Test body")
        user = User(id: 1, name: "Test name", username: "Test username", email: "test@email.test", phone: "12345", website: "Test website")
        
        postListViewModel = PostListViewModel()
        postDetailsViewModel = PostDetailsViewModel(post: post)
        postDetailsViewModel.user = user
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        postListViewController = sb.instantiateViewController(withIdentifier: POST_LIST_VC_IDENTIFIER) as? PostListViewController
        postDetailsViewController = sb.instantiateViewController(withIdentifier: POST_DETAILS_VC_IDENTIFIER) as? PostDetailsViewController
    }

    override func tearDownWithError() throws {
        postListViewController = nil
        postDetailsViewController = nil
        postListViewModel = nil
        postDetailsViewModel = nil
        post = nil
        user = nil
    }

    func testViewModels() throws {
        XCTAssertEqual(postDetailsViewModel.getPostTitle(), post.title, "Post title is not the same")
        XCTAssertEqual(postDetailsViewModel.getPostBody(), post.body, "Post body is not the same")
        XCTAssertEqual(postDetailsViewModel.getPostUserFullname(), "(\(user.name))", "User full name not insdie parenthesis")
    }
    
    func testPostListViewController() throws {
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: POST_LIST_VC_IDENTIFIER)
        XCTAssertTrue(vc is PostListViewController, "PostListViewController not exist for identifier: \(POST_LIST_VC_IDENTIFIER)")
    }
    
    func testPostDetailsViewController() throws {
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: POST_DETAILS_VC_IDENTIFIER)
        XCTAssertTrue(vc is PostDetailsViewController, "PostDetailsViewController not exist for identifier: \(POST_DETAILS_VC_IDENTIFIER)")
    }
    
    func testPostListTableCell() throws {
        let postCell = postListViewController.tableView.dequeueReusableCell(withIdentifier: POST_CELL_IDENTIFIER)

        XCTAssertNotNil(postCell, "PostCell not found for identifier: \(POST_CELL_IDENTIFIER)")
        XCTAssertTrue(postCell is PostCell, "PostCell class is different")
    }
    
    func testCommentsTableCell() throws {
        postDetailsViewController.loadView()
        let commentCell = postDetailsViewController.commentsTable.dequeueReusableCell(withIdentifier: COMMENT_CELL_IDENTIFIER)

        XCTAssertNotNil(commentCell, "CommentCell not found for identifier: \(COMMENT_CELL_IDENTIFIER)")
        XCTAssertTrue(commentCell is CommentCell, "CommentCell class is different")
    }
}
