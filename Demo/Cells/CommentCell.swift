//
//  CommentCell.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentUserNameLbl: UILabel!
    @IBOutlet weak var commentUserEmailLbl: UILabel!
    @IBOutlet weak var commentBodyLbl: UILabel!
    
    func update(with comment: Comment) {
        commentUserNameLbl.text = comment.userName
        commentUserEmailLbl.text = comment.email
        commentBodyLbl.text = comment.commentBody
    }
}
