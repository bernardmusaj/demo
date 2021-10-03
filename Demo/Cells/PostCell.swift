//
//  PostCell.swift
//  Demo
//
//  Created by Bernard Musaj on 10.4.21.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var postBodyLbl: UILabel!
    
    func update(with post: Post) {
        postTitleLbl.text = post.title
        postBodyLbl.text = post.body
    }
}
