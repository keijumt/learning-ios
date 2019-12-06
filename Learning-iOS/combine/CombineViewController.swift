//
//  CombineViewController.swift
//  learning-ios
//
//  Created by matsumoto-keiju on 2019/11/29.
//  Copyright © 2019 keijumt. All rights reserved.
//

import UIKit
import Combine

struct HogePublisher: Publisher {
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let hogeSubscription = HogeSubscription(combineIdentifier: CombineIdentifier())
        subscriber.receive(completion: .finished)
        subscriber.receive(subscription: hogeSubscription)
        _ = subscriber.receive("hoge")
    }
    
    typealias Output = String
    typealias Failure = Error
}

struct HogeSubscription: Subscription{
    func request(_ demand: Subscribers.Demand) {
    }
    
    func cancel() {
    }
    
    var combineIdentifier: CombineIdentifier
}

class CombineViewController: UIViewController {
    

            let hogePublisher = HogePublisher()
    var hogeAnyPublisher: AnyPublisher<String, Error>!
    private var cancellables = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hogeAnyPublisher = hogePublisher.eraseToAnyPublisher()
        self.hogeAnyPublisher.sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .failure(let error):
                break
            case .finished:
                break
            }
            }, receiveValue: {[weak self] value in
                print("value is \(value)")
            }).store(in: &cancellables)
    }
}
