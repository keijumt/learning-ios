//
//  UITraceViewController.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/06.
//

import UIKit

class UITraceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapTwitter(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UITraceViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "TwitterViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
}
