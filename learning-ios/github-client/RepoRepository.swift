//
//  RepoRepository.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import RxSwift

protocol RepoRepository {
    func search(query:String) -> Single<SearchRepo>
}

class RepoRepositoryImpl: RepoRepository{
    let githubApi: GithubApi!
    
    init(githubApi: GithubApi) {
        self.githubApi = githubApi
    }
    
    func search(query: String) -> Single<SearchRepo> {
        return self.githubApi.searchRepo(query: query)
    }
}
