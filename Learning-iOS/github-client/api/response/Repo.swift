//
//  Repo.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation

struct Repo : Decodable {
    let name: String
    let description: String
    let owner: Owner
    let stargazersCount: Int
    let forksCount: Int
}
