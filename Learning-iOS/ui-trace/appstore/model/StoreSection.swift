//
//  StoreSection.swift
//  Learning-iOS
//
//  Created by matsumoto-keiju on 2019/12/09.
//

import Foundation

open class StoreSection {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
}

extension StoreSection: Hashable {
    public func hash(into hasher: inout Hasher) {
         hasher.combine(id)
    }
    
    public static func == (lhs: StoreSection, rhs: StoreSection) -> Bool {
        return lhs.id == rhs.id
    }
}
