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
    
    private let api: Api
    
    init(api: Api) {
        self.api = api
    }
    
    func searchRepo(query: String) -> Single<SearchRepo> {
        return api.request(request: SearchRepoRequest(query: query))
    }
}
