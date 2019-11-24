//
//  Module1ViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit

protocol Module1ViewProtocol {
    func showItem(item: String)
}

class Module1ViewController: UIViewController, Module1ViewProtocol {
    
    var module1Presenter: Module1PresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        module1Presenter.viewDidLoad()
    }
    
    func showItem(item: String) {
         print(item)
     }
    
    @IBAction func didTapNavigateToModule2Button(_ sender: UIButton) {
        self.module1Presenter.buttonDidTap()
    }
}
