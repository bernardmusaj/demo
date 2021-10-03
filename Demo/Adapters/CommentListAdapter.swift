//
//  CommentListAdapter.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import UIKit

class CommentListAdapter: NSObject {
    
    var delegate: ListProtocol
    
    init(delegate: ListProtocol) {
        self.delegate = delegate
    }
}

//MARK: - Table view delegate & data source implementation for comments table view
extension CommentListAdapter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.numberOfItems()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COMMENT_CELL_IDENTIFIER, for: indexPath) as! CommentCell
        let comment = delegate.getData(at: indexPath) as! Comment
        cell.update(with: comment)

        return cell
    }
}
