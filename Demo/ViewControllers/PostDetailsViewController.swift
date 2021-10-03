//
//  PostDetailsViewController.swift
//  Demo
//
//  Created by Bernard Musaj on 10.4.21.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var postUsernameLbl: UILabel!
    @IBOutlet weak var postUserFullnameLbl: UILabel!
    @IBOutlet weak var postBodyLbl: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userDetailsActivityIndicator: UIActivityIndicatorView!
    
    var adapter: CommentListAdapter!
    var viewModel: PostDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeCommentListAdapter()
        initializeViewModel()
        setupPostUI()
    }
    
    func initializeCommentListAdapter()  {
        adapter = CommentListAdapter(delegate: self)
        commentsTable.delegate = adapter
        commentsTable.dataSource = adapter
    }
    
    func initializeViewModel() {
        viewModel.reloadTable = { [weak self] () in
            DispatchQueue.main.async {
                self?.commentsTable.reloadData()
            }
        }
        
        viewModel.updateCommentsLoadingStatus = { [weak self] () in
            let isLoading = self?.viewModel.isCommentSectionLoading ?? false
            
            DispatchQueue.main.async {

                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.updateUserLoadingStatus = { [weak self] () in
            
            let isPostUserDetailsLoading = self?.viewModel.isUserLoading ?? false
            
            DispatchQueue.main.async {
                    
                if isPostUserDetailsLoading {
                    self?.userDetailsActivityIndicator.startAnimating()
                } else {
                    self?.userDetailsActivityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.setupPostUserDetailsUI = { [weak self] () in
            DispatchQueue.main.async {
                self?.postUsernameLbl.isHidden = self?.viewModel.isUserLoading ?? false
                self?.postUserFullnameLbl.isHidden = self?.viewModel.isUserLoading ?? false
                
                self?.postUsernameLbl.text = self?.viewModel.getPostUserUsername()
                self?.postUserFullnameLbl.text = self?.viewModel.getPostUserFullname()
            }
        }
        
        viewModel.getUser()
        viewModel.getComments()
    }
    
    func setupPostUI() {
        postTitleLbl.text = viewModel.getPostTitle()
        postBodyLbl.text = viewModel.getPostBody()
    }
}
