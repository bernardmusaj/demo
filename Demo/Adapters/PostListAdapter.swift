//
//  PostListAdapter.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import UIKit

class PostListAdapter: NSObject {
    let delegate: SelectableListProtocol
    
    init(delegate: SelectableListProtocol) {
        self.delegate = delegate
    }
}

//MARK: - Table view delegate & data source implementation for posts table view
extension PostListAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.numberOfItems()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: POST_CELL_IDENTIFIER, for: indexPath) as! PostCell
        let post = delegate.getData(at: indexPath) as! Post
        cell.update(with: post)

        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        delegate.itemSelected(at: indexPath)
        return nil
    }
}
