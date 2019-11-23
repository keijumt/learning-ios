//
//  GithubClientDependency.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation

struct GithubClientDependency {
    static func resolveGithubViewModel() -> GithubClientViewModel {
        return GithubClientViewModel(
            repoRepository: RepoRepositoryImpl(
                githubApi: GithubApiImpl()
            )
        )
    }
}
