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
    
    func testGetMaxRssiBeacon(){
        beaconservice.initBeaconRssiList(minor_id_list: navigations.getMinorList())
        beaconservice.availableBeaconRssiList[1] = -74
        beaconservice.availableBeaconRssiList[2] = -100
        beaconservice.availableBeaconRssiList[3] = -80
        beaconservice.availableBeaconRssiList[4] = -65
        beaconservice.maxRssiBeaconMinorId = 4
        let retval = beaconservice.getMaxRssiBeacon()
        XCTAssertEqual(retval.available, true)
        XCTAssertEqual(retval.minor, 4)
        XCTAssertEqual(retval.rssi, -65)
    }
    
    func testLPF(){
        var current = Dictionary<Int, Int>()
        var old = Dictionary<Int, Int>()
        let alpha = 0.7
        
        old[1] = -100
        old[2] = -100
        old[3] = -100
        current[1] = -70
        current[2] = -80
        current[3] = -90
        
        let retval = beaconservice.LPF(currentBeaconRssiList: current, oldBeaconRssiList: old)
        for i in retval{
            let key = i.key
            XCTAssertEqual(Int((Double(current[key]!)*alpha) + (Double(old[key]!)*(1.0-alpha))), retval[key])
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
