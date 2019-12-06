//
//  Module1Router.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import UIKit

protocol Module1RouterProtocol {
    func showModule2()
}

class Module1Router {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule1() -> UIViewController {
        let view = Module1ViewController()
        let router = Module1Router(viewController: view)
        let presenter = Module1Presenter(module1View: view, module1Router: router)
        
        view.module1Presenter = presenter
        
        return view
    }
}

extension Module1Router: Module1RouterProtocol {
    func showModule2() {
        let module2View = Module2Router.assembleModule2()
        self.viewController.navigationController?.pushViewController(module2View, animated: true)
    }
}
