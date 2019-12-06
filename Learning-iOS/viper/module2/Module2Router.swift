//
//  Module2Router.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import UIKit

protocol Module2RouterProtocol {
    func showModule3()
}

class Module2Router {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule2() -> UIViewController {
        let view = Module2ViewController()
        let router = Module2Router(viewController: view)
        let presenter = Module2Presenter(module2View: view, module2Router: router)
        
        view.module2Presenter = presenter
        
        return view
    }
}

extension Module2Router: Module2RouterProtocol {
    func showModule3() {
        // TODO: navigate module3
    }
}
