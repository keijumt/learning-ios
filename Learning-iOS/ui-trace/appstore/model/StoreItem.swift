//
//  StoreItem.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/06.
//

import Foundation

struct StoreItem {
    let id: Int
    let name: String
    let description: String
    let avaterUrl: String
}

extension StoreItem: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: StoreItem, rhs: StoreItem) -> Bool {
        return lhs.id == rhs.id
    }
}
