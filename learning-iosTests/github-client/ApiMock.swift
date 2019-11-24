//
//  ApiMock.swift
//  learning-iosTests
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation

@testable import learning_ios
import RxSwift
import APIKit


class ApiMock: Api {
    
    var response: Single<Any>!
    
    func request<T>(request: T) -> Single<T.Response> where T : GithubRequest, T.Response : Decodable {
        return response.map{ $0 as! T.Response}
    }
}
