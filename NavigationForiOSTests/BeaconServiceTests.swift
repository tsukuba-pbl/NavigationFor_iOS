//
//  BeaconServiceTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/20.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class BeaconServiceTests: XCTestCase {
    let beaconservice = BeaconService()
    let navigations = NavigationEntity()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        navigations.addNavigationPoint(minor_id: 1, threshold: -80, navigation_text: "Start", type: 1)
        navigations.addNavigationPoint(minor_id: 2, threshold: -74, navigation_text: "turn right", type: 0)
        navigations.addNavigationPoint(minor_id: 3, threshold: -65, navigation_text: "turn left", type: 0)
        navigations.addNavigationPoint(minor_id: 4, threshold: -70, navigation_text: "Goal", type: 2)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitBeaconRssiList(){
        beaconservice.initBeaconRssiList(minor_id_list: navigations.getMinorList())
        for i in beaconservice.availableBeaconRssiList{
            XCTAssertEqual(i.value, -100)
        }
    }
    
    func testGetMaxRssiBeacon1(){
        beaconservice.initBeaconRssiList(minor_id_list: navigations.getMinorList())
        beaconservice.availableBeaconRssiList[1] = -74
        beaconservice.availableBeaconRssiList[2] = -100
        beaconservice.availableBeaconRssiList[3] = -80
        beaconservice.availableBeaconRssiList[4] = -65
        beaconservice.maxRssiBeaconMinorId = 4
        let retval = beaconservice.getMaxRssiBeacon()
        let maxRssiBeacon = retval.maxRssiBeacon
        XCTAssertEqual(retval.available, true)
        XCTAssertEqual(maxRssiBeacon.minorId, 4)
        XCTAssertEqual(maxRssiBeacon.rssi, -65)
    }
    
    func testGetMaxRssiBeacon2(){
        beaconservice.initBeaconRssiList(minor_id_list: navigations.getMinorList())
        beaconservice.availableBeaconRssiList[1] = -100
        beaconservice.availableBeaconRssiList[2] = -100
        beaconservice.availableBeaconRssiList[3] = -100
        beaconservice.availableBeaconRssiList[4] = -100
        beaconservice.maxRssiBeaconMinorId = 1
        let retval = beaconservice.getMaxRssiBeacon()
        let maxRssiBeacon = retval.maxRssiBeacon
        XCTAssertEqual(retval.available, false)
        XCTAssertEqual(maxRssiBeacon.minorId, -1)
        XCTAssertEqual(maxRssiBeacon.rssi, -100)
    }
    
    func testLPF(){
        var current = Dictionary<Int, Int>()
        var old = Dictionary<Int, Int>()
        var expected = Dictionary<Int, Int>()
        
        //過去のRSSI値
        old[1] = -100
        old[2] = -100
        old[3] = -100
        //現在のRSSI値
        current[1] = -70
        current[2] = -80
        current[3] = -90
        // 期待値
        // フィルタ式： z(t+1) = a*z(t) + (1-a)*z(t-1)
        // a = 0.7
        expected[1] = -79
        expected[2] = -86
        expected[3] = -93
        
        let retval = beaconservice.LPF(currentBeaconRssiList: current, oldBeaconRssiList: old)
        for i in retval{
            XCTAssertEqual(expected[i.key], retval[i.key])
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
