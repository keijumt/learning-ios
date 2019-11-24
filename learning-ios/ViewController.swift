//
//  ViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/19.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapViperButton(_ sender: UIButton) {
        let view = Module1Router.assembleModule1()
        self.navigationController?.pushViewController(view, animated:true)
    }
}

