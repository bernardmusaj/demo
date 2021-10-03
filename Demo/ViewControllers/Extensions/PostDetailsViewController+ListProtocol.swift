//
//  PostListViewController+ListProtocol.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import Foundation

//Implement ListProtocol for List of Comments
extension PostDetailsViewController: ListProtocol {

    func getData(at index: IndexPath) -> Codable {
        viewModel.getComment(at: index)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return viewModel.numberOfComments
    }
}
