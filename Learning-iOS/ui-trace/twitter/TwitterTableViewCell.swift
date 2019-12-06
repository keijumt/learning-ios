//
//  TwitterTableViewCell.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/06.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(tweet: Tweet) {
        displayNameLabel.text = tweet.displayName
        userIdLabel.text = "@\(tweet.userId)"
        contentLabel.text = tweet.content
    }
}
