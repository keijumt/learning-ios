//
//  ExampleUITableViewCell.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/22.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

class ExampleUITableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(item: String){
        self.titleLabel?.text = item
    }
}
