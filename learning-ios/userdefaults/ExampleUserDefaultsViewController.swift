//
//  UserDefaultsViewController.swift
//  learning-ios
//
//  Created by matsumoto-keiju on 2019/12/05.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import UIKit

class ExampleUserDefaultsViewController: UIViewController {
    
    private let key = "key"
    private let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var editUserDefaultTextField: UITextField!
    @IBOutlet weak var userDefaultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDefaults.register(defaults: ["key": "this is a default value"])
        
        updateLabel()
    }
    
    @IBAction func didTapSet(_ sender: UIButton) {
        let input = editUserDefaultTextField.text
        userDefaults.set(input, forKey: key)
        updateLabel()
    }
    
    private func updateLabel() {
        userDefaultLabel.text = userDefaults.string(forKey: key)
    }
}
