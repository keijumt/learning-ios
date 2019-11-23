//
//  GithubApiImpl.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import RxSwift

class GithubApiImpl: GithubApi {
    func searchRepo(query: String) -> Single<SearchRepo> {
        return Single<SearchRepo>.create { singleEvent in
            singleEvent(.success(SearchRepo(
                totalCount: 10, items: (1...10).map{ Repo(
                    name: "Name:\($0)",
                    owner: Owner(
                        login: "Owner:\($0)",
                        avatarUrl:""),
                    stargazersCount: 0,
                    forksCount: 0
                    ) }
            )))
            return Disposables.create()
        }
    }
}
