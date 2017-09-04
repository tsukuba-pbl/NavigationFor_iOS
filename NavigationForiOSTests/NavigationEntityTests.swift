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
    
    func testIsAvailableBeaconId_（成功するとき）(){
        for i in 1...12{
            let retval = navigations.isAvailableBeaconId(uuid: "12345678-1234-1234-1234-123456789ABC", minor_id: i)
            XCTAssertTrue(retval)
        }
    }
    
    func testIsAvailableBeaconId_（失敗するとき1_UUIDが違う）(){
        let retval = navigations.isAvailableBeaconId(uuid: "12345678-1234-1234-1234-123456789ABD", minor_id: 1)
        XCTAssertFalse(retval)
    }
    
    func testIsAvailableBeaconId_（失敗するとき1_minorが違う）(){
        let retval = navigations.isAvailableBeaconId(uuid: "12345678-1234-1234-1234-123456789ABC", minor_id: 20)
        XCTAssertFalse(retval)
    }
    
    func testGetNavigationText_（成功するとき）(){
        let retval1 = navigations.getNavigationText(route_id: 1)
        XCTAssertEqual(retval1, "Start")
        let retval2 = navigations.getNavigationText(route_id: 2)
        XCTAssertEqual(retval2, "turn right")
    }
    
    func testGetNavigationText_（失敗するとき）(){
        let retval1 = navigations.getNavigationText(route_id: 3)
        XCTAssertNotEqual(retval1, "turn right")
        let retval2 = navigations.getNavigationText(route_id: 4)
        XCTAssertNotEqual(retval2, "Start")
    }
    
    func testGetBeaconsThreshold_成功するとき(){
        let retval1 = navigations.getBeaconsThreshold(route_id: 1)
        XCTAssertEqual(retval1[0].minor_id, 1)
        XCTAssertEqual(retval1[1].minor_id, 2)
        XCTAssertEqual(retval1[2].minor_id, 3)
        XCTAssertEqual(retval1[0].threshold, -70)
        XCTAssertEqual(retval1[1].threshold, -75)
        XCTAssertEqual(retval1[2].threshold, -80)
    }
    
    func testGetMinorList_成功するとき(){
        let retval = navigations.getMinorList()
        for i in 1...12{
            XCTAssertTrue(retval.contains(i))
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
