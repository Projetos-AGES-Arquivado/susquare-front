//
//  SusquareTests.swift
//  SusquareTests
//
//  Created by Gabriel Paul on 17/04/18.
//  Copyright © 2018 AGES. All rights reserved.
//

import XCTest
@testable import SUSquare

class SusquareTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitial() {
        XCTAssertNotNil(User.sharedInstance.appToken)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
        }
    }
}
