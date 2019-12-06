//
//  Tweet.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/06.
//

import Foundation

struct Tweet {
    let id: Int
    let displayName: String
    let userId: String
    let content: String
    let avatarUrl: String
    let date: Double
}

extension Tweet: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        return lhs.id == rhs.id
    }
}
