//
//  Api.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import RxSwift
import APIKit

protocol Api {
    func request<T>(request: T) -> Single<T.Response> where T: GithubRequest, T.Response: Decodable
}

class ApiImpl: Api {
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func request<T>(request: T) -> Single<T.Response> where T : GithubRequest, T.Response : Decodable {
        return Single<T.Response>.create { singleEvent in
            self.session.send(request) { result in
                switch result {
                case .success(let response):
                    singleEvent(.success(response))
                case .failure(let error):
                    singleEvent(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
