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
        
        //ポイント1
        var beaconThresholdList1: [BeaconThreshold] = []
        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 9, rssi: -80))
        var beaconThresholdList2: [BeaconThreshold] = []
        beaconThresholdList2.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 9, rssi: -80))
        var beaconThresholdList3: [BeaconThreshold] = []
        beaconThresholdList3.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, rssi: -80))
        var beacons1: [[BeaconThreshold]] = [[]]
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        navigations.addNavigationPoint(route_id: 1, navigation_text: "Start", expectedBeacons: beacons1, isStart: 1, isGoal: 0, isCrossroad: 0, isRoad: 1)
        
        //ポイント2
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beacons1 = [[]]
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        navigations.addNavigationPoint(route_id: 2, navigation_text: "turn right", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 1, isRoad: 0)
        
        //ポイント3
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beacons1 = [[]]
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        navigations.addNavigationPoint(route_id: 3, navigation_text: "straight", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1)
        
        //ポイント4
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beacons1 = [[]]
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)

        navigations.addNavigationPoint(route_id: 4, navigation_text: "turn left", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1)
        
        //ポイント5
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beacons1 = [[]]
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        
        navigations.addNavigationPoint(route_id: 5, navigation_text: "straight", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1)
        
        //ポイント6
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList1.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList2.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconThreshold(minor_id: 1, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 2, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 3, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 4, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 5, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 6, rssi: -80))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, rssi: -70))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, rssi: -75))
        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, rssi: -80))
        beacons1 = [[]]
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        
        navigations.addNavigationPoint(route_id: 6, navigation_text: "Goal", expectedBeacons: beacons1, isStart: 0, isGoal: 1, isCrossroad: 1, isRoad: 0)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetStartRouteId(){
        XCTAssertEqual(navigations.getStartRouteId(), 1)
    }
    
    func testGetGoalRouteId(){
        XCTAssertEqual(navigations.getGoalRouteId(), 6)
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
    
    func testGetNavigationText(){
        let retval1 = navigations.getNavigationText(route_id: 1)
        XCTAssertEqual(retval1, "Start")
        let retval2 = navigations.getNavigationText(route_id: 3)
        XCTAssertEqual(retval2, "straight")
    }
    
//    func testGetBeaconsThreshold_成功するとき(){
//        let retval1 = navigations.getBeaconsThreshold(route_id: 1)
//        XCTAssertEqual(retval1[0].minor_id, 1)
//        XCTAssertEqual(retval1[1].minor_id, 2)
//        XCTAssertEqual(retval1[2].minor_id, 3)
//        XCTAssertEqual(retval1[0].rssi, -70)
//        XCTAssertEqual(retval1[1].rssi, -75)
//        XCTAssertEqual(retval1[2].rssi, -80)
//    }
    
//    func testGetMinorList_成功するとき(){
//        let retval = navigations.getMinorList()
//        for i in 1...retval.count{
//            XCTAssertTrue(retval.contains(i))
//        }
//    }
    
//    func testGetRouteIdFromMinorId(){
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 1), 1)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 2), 1)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 3), 1)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 4), 2)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 5), 2)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 6), 2)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 7), 3)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 8), 3)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 9), 3)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 10), 4)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 11), 4)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 12), 4)
//        XCTAssertEqual(navigations.getRouteIdFromMinorId(minor_id: 13), -1)
//    }
    
//    func testGetBeaconThresholdFromMinorId(){
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 1), -70)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 2), -75)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 3), -80)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 4), -70)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 5), -75)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 6), -80)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 7), -70)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 8), -75)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 9), -80)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 10), -70)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 11), -75)
//        XCTAssertEqual(navigations.getBeaconThresholdFromMinorId(minor_id: 12), -80)
//        
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
