//
//  PostListViewController+SelectableList.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import Foundation

//Implement ListProtocol, SelectableListProtocol for List of Posts
extension PostListViewController: ListProtocol, SelectableListProtocol {
    
    func getData(at index: IndexPath) -> Codable {
        viewModel.getPost(at: index)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        viewModel.numberOfPosts
    }
    
    //MARK: SelectableListProtocol implementation
    func itemSelected(at index: IndexPath) {
        viewModel.selectedPost = viewModel.getPost(at: index)
        performSegue(withIdentifier: POST_DETAILS_SEGUE_IDENTIFIER, sender: nil)
    }
}
