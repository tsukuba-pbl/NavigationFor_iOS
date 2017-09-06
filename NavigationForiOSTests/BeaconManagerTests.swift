//
//  beaconManagerTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/20.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class BeaconManagerTests: XCTestCase {
    let beaconManager = BeaconManager()
    let navigations = NavigationEntity()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //ポイント1
        var beaconThresholdList1: Array<BeaconThreshold>! = []
        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, threshold: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, threshold: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, threshold: -80))
        navigations.addNavigationPoint(route_id: 1, navigation_text: "Start", expectedBeacons: beaconThresholdList1)
        //ポイント2
        var beaconThresholdList2: Array<BeaconThreshold>! = []
        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, threshold: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, threshold: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, threshold: -80))
        navigations.addNavigationPoint(route_id: 2, navigation_text: "turn right", expectedBeacons: beaconThresholdList2)
        //ポイント3
        var beaconThresholdList3: Array<BeaconThreshold>! = []
        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, threshold: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, threshold: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, threshold: -80))
        navigations.addNavigationPoint(route_id: 3, navigation_text: "turn left", expectedBeacons: beaconThresholdList3)
        //ポイント4
        var beaconThresholdList4: Array<BeaconThreshold>! = []
        beaconThresholdList4.append(BeaconThreshold(minor_id: 10, threshold: -70))
        beaconThresholdList4.append(BeaconThreshold(minor_id: 11, threshold: -75))
        beaconThresholdList4.append(BeaconThreshold(minor_id: 12, threshold: -80))
        navigations.addNavigationPoint(route_id: 4, navigation_text: "Goal", expectedBeacons: beaconThresholdList4)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testIsAvailableBeaconId_（成功するとき）(){
        for i in 1...navigations.getMinorList().count{
            let retval = beaconManager.isAvailableBeaconId(navigations: navigations, uuid: "12345678-1234-1234-1234-123456789ABC", minor_id: i)
            XCTAssertTrue(retval)
        }
    }
    
    func testIsAvailableBeaconId_（失敗するとき1_UUIDが違う）(){
        let retval = beaconManager.isAvailableBeaconId(navigations: navigations, uuid: "12345678-1234-1234-1234-123456789ABD", minor_id: 1)
        XCTAssertFalse(retval)
    }
    
    func testIsAvailableBeaconId_（失敗するとき1_minorが違う）(){
        let retval = beaconManager.isAvailableBeaconId(navigations: navigations, uuid: "12345678-1234-1234-1234-123456789ABC", minor_id: 20)
        XCTAssertFalse(retval)
    }

    
    func testInitBeaconRssiList(){
        XCTAssertEqual(navigations.getMinorList().count, 12)
        beaconManager.initBeaconRssiList(minor_id_list: navigations.getMinorList())
        for i in beaconManager.availableBeaconRssiList{
            XCTAssertEqual(i.value, -100)
        }
    }
    
    func testGetMaxRssiBeacon1(){
        beaconManager.initBeaconRssiList(minor_id_list: navigations.getMinorList())
        beaconManager.availableBeaconRssiList[1] = -74
        beaconManager.availableBeaconRssiList[2] = -100
        beaconManager.availableBeaconRssiList[3] = -80
        beaconManager.availableBeaconRssiList[4] = -65
        beaconManager.maxRssiBeaconMinorId = 4
        let retval = beaconManager.getMaxRssiBeacon()
        let maxRssiBeacon = retval.maxRssiBeacon
        XCTAssertEqual(retval.available, true)
        XCTAssertEqual(maxRssiBeacon.minorId, 4)
        XCTAssertEqual(maxRssiBeacon.rssi, -65)
    }
    
    func testGetMaxRssiBeacon2(){
        beaconManager.initBeaconRssiList(minor_id_list: navigations.getMinorList())
        beaconManager.availableBeaconRssiList[1] = -100
        beaconManager.availableBeaconRssiList[2] = -100
        beaconManager.availableBeaconRssiList[3] = -100
        beaconManager.availableBeaconRssiList[4] = -100
        beaconManager.maxRssiBeaconMinorId = 1
        let retval = beaconManager.getMaxRssiBeacon()
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
        
        let retval = beaconManager.LPF(currentBeaconRssiList: current, oldBeaconRssiList: old)
        for i in retval{
            XCTAssertEqual(expected[i.key], retval[i.key])
        }
    }
    
    func testGetReceivedBeaconsRssi(){
        XCTAssertTrue(beaconManager.getReceivedBeaconsRssi().isEmpty)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
