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
    
    func testGetEuclidResult_実際とビーコンの差分がない場合(){
        let receivedBeaconRssiList = [1: -80, 2: -70, 3: -90, 4: -80]
        let expectedBeaconRssiList = [1: -80, 2: -70, 3: -90, 4: -80]
        XCTAssertEqual(lpfEuclid.getEuclidResult(receivedBeaconRssiList: receivedBeaconRssiList, expectedBeaconRssiList: expectedBeaconRssiList), 0.0)
    }
    
    func testGetEuclidResult_実際とビーコンの差分がある場合(){
        let receivedBeaconRssiList = [1: -80, 2: -70, 3: -95, 4: -80]
        let expectedBeaconRssiList = [1: -90, 2: -95, 3: -90, 4: -70]
        XCTAssertEqual(lpfEuclid.getEuclidResult(receivedBeaconRssiList: receivedBeaconRssiList, expectedBeaconRssiList: expectedBeaconRssiList), 29.15)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
