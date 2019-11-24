//
//  RepoRepositoryImpl.swift
//  learning-iosTests
//
//  Created by 松本圭樹 on 2019/11/24.
//  Copyright © 2019 keijumt. All rights reserved.
//

import XCTest
@testable import learning_ios
import RxSwift
import RxBlocking

class RepoRepositoryImplSpec: XCTestCase {
    
    var api: ApiMock!
    var repoRepository: RepoRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        self.api = ApiMock()
        self.repoRepository = RepoRepositoryImpl(githubApi: GithubApiImpl(api: self.api))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func successSearchRepo() {
        let repo = Repo(name: "name", description: "description", owner: Owner(login: "login", avatarUrl: "url"), stargazersCount: 0, forksCount: 0)
        let searchRepo = SearchRepo(totalCount: 1, items: [repo])
        api.response = Single.just(searchRepo)
        XCTAssertEqual(try repoRepository.search(query: "").toBlocking().first()?.totalCount, 0)
    }
}
