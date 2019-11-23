//
//  GithubApi.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

protocol GithubApi {
    func searchRepo(query: String) -> Single<SearchRepo>
}

class GithubApiImpl: GithubApi {
    func searchRepo(query: String) -> Single<SearchRepo> {
        return Single<SearchRepo>.create { singleEvent in
            Session.send(SearchRepoRequest(query: query)) { result in
                switch result {
                case .success(let response):
                    singleEvent(.success(response))
                case .failure(let error):
                    print(error)
                    singleEvent(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
