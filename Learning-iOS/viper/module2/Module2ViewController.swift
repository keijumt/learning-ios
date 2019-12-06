//
//  Module2ViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

protocol Module2ViewProtocol {
    func showItem(item: String)
}

class Module2ViewController: UIViewController, Module2ViewProtocol {

    var module2Presenter: Module2PresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        module2Presenter.viewDidLoad()
    }
    
    func showItem(item: String) {
        print(item)
    }
}
