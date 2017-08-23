//
//  NavigationEntityTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/23.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class NavigationEntityTests: XCTestCase {
    let navigations = NavigationEntity()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUsingUUID_成功するとき（黒いビーコンの識別子）() {
        let uuidlist = navigations.getUUIDList()
        let retval = uuidlist.contains("12345678-1234-1234-1234-123456789ABC")
        XCTAssertTrue(retval)
    }
    
    func testGetUsingUUID_（失敗するとき）() {
        let uuidlist = navigations.getUUIDList()
        let retval = uuidlist.contains("B9407F30-F5F8-466E-AFF9-25556B57FE6B")
        XCTAssertFalse(retval)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
