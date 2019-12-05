//
//  NotificationCenterViewController.swift
//  learning-ios
//
//  Created by matsumoto-keiju on 2019/12/05.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

class NotificationCenterViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveValue(notification:)), name: .hoge, object: nil)
    }
    
    @objc func receiveValue(notification: Notification){
        if let value = notification.userInfo?["value"] as? String {
            sendValueLabel.text = value
        }
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        NotificationCenter.default.post(name: .hoge, object: nil, userInfo: ["value":textField.text ?? ""])
    }
}

extension Notification.Name {
    static let hoge = Notification.Name("hoge")
}
