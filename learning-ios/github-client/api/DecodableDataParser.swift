//
//  DecodableDataParser.swift
//  learning-ios
//
//  Created by 松本圭樹 on 2019/11/23.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

final class DecodableDataParser: DataParser {
    var contentType: String? {        
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}
