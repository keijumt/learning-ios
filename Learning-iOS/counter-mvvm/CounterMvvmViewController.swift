//
//  CounterMvvmViewController.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/20.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CounterMvvmViewController: UIViewController {

    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var viewModel: CounterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let input = CounterInput(didTapButton: countButton.rx.tap.asObservable())
        self.viewModel = CounterViewModel()
        let output = viewModel.transform(input: input)
        output.count.drive(self.countLabel.rx.text).disposed(by: disposeBag)
    }
}
