//
//  LpfEuclidTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/06.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class LpfEuclidTests: XCTestCase {
    let lpfEuclid = LpfEuclid()
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetBeaconDist(){
        //小数点第一位まで値が同じかをテストする
        XCTAssertEqual(round(lpfEuclid.getBeaconDist(rssi: -75)*10.0)/10.0, 1.0)
        XCTAssertEqual(round(lpfEuclid.getBeaconDist(rssi: -80)*10.0)/10.0, 1.8)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
