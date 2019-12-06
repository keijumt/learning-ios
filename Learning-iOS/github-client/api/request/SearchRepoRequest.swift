//
//  SearchRepoRequest.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import APIKit

struct SearchRepoRequest: GithubRequest {
    typealias Response = SearchRepo
    
    let method: HTTPMethod = .get
    let path: String = "search/repositories"
    var parameters: Any? {
        return ["q": query, "page": 1]
    }
    
    let query: String
    
    init(query: String) {
        self.query = query
    }
}
