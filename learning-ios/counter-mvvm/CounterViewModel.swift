//
//  CounterViewModel.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/20.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CounterViewModel {
    
    private let disposeBag = DisposeBag()
    
    func transform(input: CounterInput) -> CounterOutput{
        let _count = BehaviorRelay<Int>(value: 0)
        let count = _count.scan(0){ sum, n in
            sum + n
        }.map{ "\($0)" }
        input.didTapButton.asObservable().subscribe{_ in
            _count.accept(1)
        }.disposed(by: disposeBag)
        return CounterOutput(count: count.asDriver(onErrorDriveWith: Driver.empty()))
    }
}

struct CounterOutput{
    let count:Driver<String>
}

struct CounterInput{
    let didTapButton:Observable<Void>
}
