//
//  PostListViewController.swift
//  Demo
//
//  Created by Bernard Musaj on 9.4.21.
//

import UIKit

class PostListViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var adapter : PostListAdapter!
    
    lazy var viewModel: PostListViewModel = {
        return PostListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePostListAdapter()
        initializeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
    }
    
    func initializePostListAdapter() {
        adapter = PostListAdapter(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    func initializeViewModel() {
        
        viewModel.reloadTable = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                
                let isLoading = self?.viewModel.isLoading ?? false
                
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.getPosts()
    }

    @IBAction func clearCacheBtn(_ sender: UIBarButtonItem) {
        _ = ManagedPost.deleteAll()
        _ = ManagedComment.deleteAll()
        _ = ManagedUser.deleteAll()
        
        viewModel.clearCache()
        viewModel.getPosts()
    }
    
    // MARK: - Navigation to Post details
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case POST_DETAILS_SEGUE_IDENTIFIER:
                let vc = segue.destination as! PostDetailsViewController
                let postDetailsViewModel = PostDetailsViewModel(post: viewModel.selectedPost!)
                vc.viewModel = postDetailsViewModel
            default:
                break
        }
    }
}
