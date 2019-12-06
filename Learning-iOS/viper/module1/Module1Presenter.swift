//
//  Module1Presenter.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation

protocol Module1PresenterProtocol {
    func viewDidLoad()
    func buttonDidTap()
}

class Module1Presenter: Module1PresenterProtocol {
    
    private let module1View: Module1ViewProtocol!
    private let module1Router: Module1Router
    
    init(module1View: Module1ViewProtocol, module1Router: Module1Router) {
        self.module1View = module1View
        self.module1Router = module1Router
    }
    
    func viewDidLoad() {
        self.module1View.showItem(item: "module1 item")
    }
    
    func buttonDidTap() {
        self.module1Router.showModule2()
    }
}
