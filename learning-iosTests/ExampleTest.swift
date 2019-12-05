//
//  ExampleTest.swift
//  learning-iosTests
//
//  Created by matsumoto-keiju on 2019/12/05.
//  Copyright © 2019 keijumt. All rights reserved.
//

import Foundation
import XCTest
@testable import learning_ios

class ExampleTest: XCTestCase {

    override func setUp() {
        super.setUp()
        print("setup")
    }
    
    override func tearDown() {
        print("tearDown")
    }
    
    func testHoge() {
        print("testHoge")
    }
    
    func testPiyo() {
        print("testPiyo")
    }
}
