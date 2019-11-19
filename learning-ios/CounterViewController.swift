//
//  CounterViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/19.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    
    @IBOutlet weak var countLabal: UILabel!
    
    private var count = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countLabal.text = "\(count)"
    }
    @IBAction func onClickCountButton(_ sender: Any) {
        self.count += 1
        self.countLabal.text = "\(count)"
    }
}
