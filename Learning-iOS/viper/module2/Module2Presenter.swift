//
//  Module2Presenter.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation

protocol Module2PresenterProtocol {
    func viewDidLoad()
}

class Module2Presenter: Module2PresenterProtocol {
    
    private let module2View: Module2ViewProtocol
    private let module2Router: Module2RouterProtocol
    
    init(module2View: Module2ViewProtocol, module2Router: Module2Router) {
        self.module2View = module2View
        self.module2Router = module2Router
    }
    
    func viewDidLoad() {
        self.module2View.showItem(item: "module2 item")
    }
}
