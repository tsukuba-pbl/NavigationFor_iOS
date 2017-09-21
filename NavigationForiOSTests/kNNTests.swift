//
//  kNNTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/12.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class kNNTests: XCTestCase {
    let navigations = NavigationEntity()
    let kNN = KNN()
    
    override func setUp() {
        super.setUp()
        
        //ポイント1
        var beaconThresholdList1: [BeaconRssi] = []
        beaconThresholdList1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 9, rssi: -100))
        var beaconThresholdList2: [BeaconRssi] = []
        beaconThresholdList2.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 9, rssi: -100))
        var beaconThresholdList3: [BeaconRssi] = []
        beaconThresholdList3.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 9, rssi: -100))
        var beacons1 = [[BeaconRssi]]()
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        navigations.addNavigationPoint(route_id: 1, navigation_text: "Start", expectedBeacons: beacons1, isStart: 1, isGoal: 0, isCrossroad: 0, isRoad: 1, rotate_degree: 0)
        
        //ポイント2
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconRssi(minor_id: 1, rssi: -84))
        beaconThresholdList1.append(BeaconRssi(minor_id: 2, rssi: -79))
        beaconThresholdList1.append(BeaconRssi(minor_id: 3, rssi: -79))
        beaconThresholdList1.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconRssi(minor_id: 1, rssi: -86))
        beaconThresholdList2.append(BeaconRssi(minor_id: 2, rssi: -80))
        beaconThresholdList2.append(BeaconRssi(minor_id: 3, rssi: -74))
        beaconThresholdList2.append(BeaconRssi(minor_id: 4, rssi: -99))
        beaconThresholdList2.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconRssi(minor_id: 1, rssi: -85))
        beaconThresholdList3.append(BeaconRssi(minor_id: 2, rssi: -79))
        beaconThresholdList3.append(BeaconRssi(minor_id: 3, rssi: -74))
        beaconThresholdList3.append(BeaconRssi(minor_id: 4, rssi: -99))
        beaconThresholdList3.append(BeaconRssi(minor_id: 5, rssi: -98))
        beaconThresholdList3.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 9, rssi: -100))
        beacons1.removeAll()
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        navigations.addNavigationPoint(route_id: 2, navigation_text: "turn left", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 1, isRoad: 0, rotate_degree: -90)
        
        //ポイント3
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconRssi(minor_id: 1, rssi: -85))
        beaconThresholdList1.append(BeaconRssi(minor_id: 2, rssi: -88))
        beaconThresholdList1.append(BeaconRssi(minor_id: 3, rssi: -90))
        beaconThresholdList1.append(BeaconRssi(minor_id: 4, rssi: -89))
        beaconThresholdList1.append(BeaconRssi(minor_id: 5, rssi: -90))
        beaconThresholdList1.append(BeaconRssi(minor_id: 6, rssi: -95))
        beaconThresholdList1.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconRssi(minor_id: 1, rssi: -90))
        beaconThresholdList2.append(BeaconRssi(minor_id: 2, rssi: -89))
        beaconThresholdList2.append(BeaconRssi(minor_id: 3, rssi: -85))
        beaconThresholdList2.append(BeaconRssi(minor_id: 4, rssi: -90))
        beaconThresholdList2.append(BeaconRssi(minor_id: 5, rssi: -95))
        beaconThresholdList2.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconRssi(minor_id: 1, rssi: -93))
        beaconThresholdList3.append(BeaconRssi(minor_id: 2, rssi: -94))
        beaconThresholdList3.append(BeaconRssi(minor_id: 3, rssi: -84))
        beaconThresholdList3.append(BeaconRssi(minor_id: 4, rssi: -90))
        beaconThresholdList3.append(BeaconRssi(minor_id: 5, rssi: -94))
        beaconThresholdList3.append(BeaconRssi(minor_id: 6, rssi: -85))
        beaconThresholdList3.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 9, rssi: -100))
        beacons1.removeAll()
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        navigations.addNavigationPoint(route_id: 3, navigation_text: "straight", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1, rotate_degree: 0)
        
        //ポイント4
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconRssi(minor_id: 1, rssi: -99))
        beaconThresholdList1.append(BeaconRssi(minor_id: 2, rssi: -99))
        beaconThresholdList1.append(BeaconRssi(minor_id: 3, rssi: -97))
        beaconThresholdList1.append(BeaconRssi(minor_id: 4, rssi: -70))
        beaconThresholdList1.append(BeaconRssi(minor_id: 5, rssi: -77))
        beaconThresholdList1.append(BeaconRssi(minor_id: 6, rssi: -87))
        beaconThresholdList1.append(BeaconRssi(minor_id: 7, rssi: -93))
        beaconThresholdList1.append(BeaconRssi(minor_id: 8, rssi: -96))
        beaconThresholdList1.append(BeaconRssi(minor_id: 9, rssi: -85))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconRssi(minor_id: 1, rssi: -99))
        beaconThresholdList2.append(BeaconRssi(minor_id: 2, rssi: -99))
        beaconThresholdList2.append(BeaconRssi(minor_id: 3, rssi: -99))
        beaconThresholdList2.append(BeaconRssi(minor_id: 4, rssi: -71))
        beaconThresholdList2.append(BeaconRssi(minor_id: 5, rssi: -84))
        beaconThresholdList2.append(BeaconRssi(minor_id: 6, rssi: -81))
        beaconThresholdList2.append(BeaconRssi(minor_id: 7, rssi: -95))
        beaconThresholdList2.append(BeaconRssi(minor_id: 8, rssi: -95))
        beaconThresholdList2.append(BeaconRssi(minor_id: 9, rssi: -87))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconRssi(minor_id: 1, rssi: -99))
        beaconThresholdList3.append(BeaconRssi(minor_id: 2, rssi: -99))
        beaconThresholdList3.append(BeaconRssi(minor_id: 3, rssi: -99))
        beaconThresholdList3.append(BeaconRssi(minor_id: 4, rssi: -70))
        beaconThresholdList3.append(BeaconRssi(minor_id: 5, rssi: -77))
        beaconThresholdList3.append(BeaconRssi(minor_id: 6, rssi: -80))
        beaconThresholdList3.append(BeaconRssi(minor_id: 7, rssi: -92))
        beaconThresholdList3.append(BeaconRssi(minor_id: 8, rssi: -99))
        beaconThresholdList3.append(BeaconRssi(minor_id: 9, rssi: -85))
        beacons1.removeAll()
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        
        navigations.addNavigationPoint(route_id: 4, navigation_text: "turn right", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1, rotate_degree: 90)
        
        //ポイント5
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 4, rssi: -82))
        beaconThresholdList1.append(BeaconRssi(minor_id: 5, rssi: -85))
        beaconThresholdList1.append(BeaconRssi(minor_id: 6, rssi: -88))
        beaconThresholdList1.append(BeaconRssi(minor_id: 7, rssi: -83))
        beaconThresholdList1.append(BeaconRssi(minor_id: 8, rssi: -86))
        beaconThresholdList1.append(BeaconRssi(minor_id: 9, rssi: -88))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 4, rssi: -89))
        beaconThresholdList2.append(BeaconRssi(minor_id: 5, rssi: -87))
        beaconThresholdList2.append(BeaconRssi(minor_id: 6, rssi: -81))
        beaconThresholdList2.append(BeaconRssi(minor_id: 7, rssi: -83))
        beaconThresholdList2.append(BeaconRssi(minor_id: 8, rssi: -84))
        beaconThresholdList2.append(BeaconRssi(minor_id: 9, rssi: -87))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 4, rssi: -89))
        beaconThresholdList3.append(BeaconRssi(minor_id: 5, rssi: -85))
        beaconThresholdList3.append(BeaconRssi(minor_id: 6, rssi: -83))
        beaconThresholdList3.append(BeaconRssi(minor_id: 7, rssi: -86))
        beaconThresholdList3.append(BeaconRssi(minor_id: 8, rssi: -88))
        beaconThresholdList3.append(BeaconRssi(minor_id: 9, rssi: -82))
        beacons1.removeAll()
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        
        navigations.addNavigationPoint(route_id: 5, navigation_text: "straight", expectedBeacons: beacons1, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1, rotate_degree: 0)
        
        //ポイント6
        beaconThresholdList1 = []
        beaconThresholdList1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList1.append(BeaconRssi(minor_id: 4, rssi: -87))
        beaconThresholdList1.append(BeaconRssi(minor_id: 5, rssi: -98))
        beaconThresholdList1.append(BeaconRssi(minor_id: 6, rssi: -95))
        beaconThresholdList1.append(BeaconRssi(minor_id: 7, rssi: -71))
        beaconThresholdList1.append(BeaconRssi(minor_id: 8, rssi: -76))
        beaconThresholdList1.append(BeaconRssi(minor_id: 9, rssi: -63))
        beaconThresholdList2 = []
        beaconThresholdList2.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList2.append(BeaconRssi(minor_id: 4, rssi: -87))
        beaconThresholdList2.append(BeaconRssi(minor_id: 5, rssi: -99))
        beaconThresholdList2.append(BeaconRssi(minor_id: 6, rssi: -97))
        beaconThresholdList2.append(BeaconRssi(minor_id: 7, rssi: -70))
        beaconThresholdList2.append(BeaconRssi(minor_id: 8, rssi: -74))
        beaconThresholdList2.append(BeaconRssi(minor_id: 9, rssi: -61))
        beaconThresholdList3 = []
        beaconThresholdList3.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList3.append(BeaconRssi(minor_id: 4, rssi: -87))
        beaconThresholdList3.append(BeaconRssi(minor_id: 5, rssi: -99))
        beaconThresholdList3.append(BeaconRssi(minor_id: 6, rssi: -99))
        beaconThresholdList3.append(BeaconRssi(minor_id: 7, rssi: -71))
        beaconThresholdList3.append(BeaconRssi(minor_id: 8, rssi: -75))
        beaconThresholdList3.append(BeaconRssi(minor_id: 9, rssi: -62))
        beacons1.removeAll()
        beacons1.append(beaconThresholdList1)
        beacons1.append(beaconThresholdList2)
        beacons1.append(beaconThresholdList3)
        
        navigations.addNavigationPoint(route_id: 6, navigation_text: "Goal", expectedBeacons: beacons1, isStart: 0, isGoal: 1, isCrossroad: 1, isRoad: 0, rotate_degree: 0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //route id 2にいるとき(交差点到達)
    func testGetCurrentPoint1(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -84, 2: -79, 3:-79, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-100]
        let retval = kNN.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, currentRouteId: 2)
        XCTAssertEqual(retval, POINT.CROSSROAD)
    }
    
    //route id 2にいるとき（交差点到達前）
    func testGetCurrentPoint(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -95, 2: -92, 3:-93, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-100]
        let retval = kNN.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, currentRouteId: 2)
        XCTAssertEqual(retval, POINT.OTHER)
    }
    
    //route id 6にいるとき(目的地到達)
    func testGetCurrentPoint3(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -100, 2: -100, 3:-100, 4:-87, 5:-87, 6:-87, 7:-71, 8:-70, 9:-70]
        let retval = kNN.getCurrentPoint(navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, currentRouteId: 6)
        XCTAssertEqual(retval, POINT.GOAL)
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

