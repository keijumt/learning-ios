//
//  GithubClientViewModel.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GithubClientViewModel {
    
    private let repoRepository: RepoRepository!
    
    init(repoRepository: RepoRepository) {
        self.repoRepository = repoRepository
    }
    
    func transform(input: GithubClientInput) -> GithubClientOutput {
        return GithubClientOutput(repos: repoRepository.search(query: "swift")
            .map{ $0.items }
            .asDriver(onErrorDriveWith: Driver.empty()))
    }
}

struct GithubClientInput {
}

struct GithubClientOutput {
    let repos: Driver<[Repo]>
}
