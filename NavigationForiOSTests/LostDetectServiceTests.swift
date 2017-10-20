//
//  LostDetectServiceTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/10/19.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class LostDetectServiceTests: XCTestCase {

    let navigations = NavigationEntity()
    let lostDetectService = LostDetectService()
    
    override func setUp() {
        super.setUp()
        
        //ポイント1
        var beaconThresholdList1_1: [BeaconRssi] = []
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 1, rssi: -80))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 2, rssi: -83))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 3, rssi: -79))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList1_1.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList1_2: [BeaconRssi] = []
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 1, rssi: -81))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 2, rssi: -80))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 3, rssi: -80))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList1_2.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList1_3: [BeaconRssi] = []
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 1, rssi: -78))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 2, rssi: -77))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 3, rssi: -80))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList1_3.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beacons1 = [[BeaconRssi]]()
        beacons1.append(beaconThresholdList1_1)
        beacons1.append(beaconThresholdList1_2)
        beacons1.append(beaconThresholdList1_3)
        navigations.addNavigationPoint(route_id: 1, navigation_text: "Start", expectedBeacons: beacons1, isStart: 1, isGoal: 0, isCrossroad: 1, isRoad: 0, rotate_degree: 0, steps: 0)
        
        //ポイント2
        var beaconThresholdList2_1: [BeaconRssi] = []
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 1, rssi: -84))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 2, rssi: -89))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 3, rssi: -89))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 4, rssi: -84))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 5, rssi: -80))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 6, rssi: -82))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList2_1.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList2_2: [BeaconRssi] = []
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 1, rssi: -86))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 2, rssi: -87))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 3, rssi: -89))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 4, rssi: -86))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 5, rssi: -83))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 6, rssi: -83))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList2_2.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList2_3: [BeaconRssi] = []
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 1, rssi: -85))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 2, rssi: -89))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 3, rssi: -84))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 4, rssi: -89))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 5, rssi: -88))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 6, rssi: -80))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList2_3.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beacons2 = [[BeaconRssi]]()
        beacons2.append(beaconThresholdList2_1)
        beacons2.append(beaconThresholdList2_2)
        beacons2.append(beaconThresholdList2_3)
        navigations.addNavigationPoint(route_id: 2, navigation_text: "straight", expectedBeacons: beacons2, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1, rotate_degree: 0, steps: 20)
        
        //ポイント3
        var beaconThresholdList3_1: [BeaconRssi] = []
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 4, rssi: -76))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 5, rssi: -78))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 6, rssi: -72))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList3_1.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList3_2: [BeaconRssi] = []
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 1, rssi: -96))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 2, rssi: -97))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 3, rssi: -94))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 4, rssi: -79))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 5, rssi: -74))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 6, rssi: -80))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList3_2.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList3_3: [BeaconRssi] = []
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 1, rssi: -95))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 2, rssi: -99))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 3, rssi: -94))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 4, rssi: -79))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 5, rssi: -78))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList3_3.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beacons3 = [[BeaconRssi]]()
        beacons3.append(beaconThresholdList3_1)
        beacons3.append(beaconThresholdList3_2)
        beacons3.append(beaconThresholdList3_3)
        navigations.addNavigationPoint(route_id: 3, navigation_text: "turn left", expectedBeacons: beacons3, isStart: 0, isGoal: 0, isCrossroad: 1, isRoad: 0, rotate_degree: -90, steps: 0)
        
        //ポイント4
        var beaconThresholdList4_1: [BeaconRssi] = []
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 4, rssi: -86))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 5, rssi: -89))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 6, rssi: -84))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 7, rssi: -88))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 8, rssi: -84))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 9, rssi: -83))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList4_1.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList4_2: [BeaconRssi] = []
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 4, rssi: -90))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 5, rssi: -95))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 6, rssi: -86))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 7, rssi: -90))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 8, rssi: -87))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 9, rssi: -85))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList4_2.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beaconThresholdList4_3: [BeaconRssi] = []
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 4, rssi: -90))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 5, rssi: -94))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 6, rssi: -85))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 7, rssi: -85))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 8, rssi: -88))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 9, rssi: -84))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 10, rssi: -100))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 11, rssi: -100))
        beaconThresholdList4_3.append(BeaconRssi(minor_id: 12, rssi: -100))
        var beacons4 = [[BeaconRssi]]()
        beacons4.append(beaconThresholdList4_1)
        beacons4.append(beaconThresholdList4_2)
        beacons4.append(beaconThresholdList4_3)
        navigations.addNavigationPoint(route_id: 4, navigation_text: "straight", expectedBeacons: beacons4, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1, rotate_degree: 0, steps: 60)
        
        //ポイント5
        var beaconThresholdList5_1: [BeaconRssi] = []
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 7, rssi: -74))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 8, rssi: -78))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 9, rssi: -76))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 10, rssi: -90))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 11, rssi: -90))
        beaconThresholdList5_1.append(BeaconRssi(minor_id: 12, rssi: -90))
        var beaconThresholdList5_2: [BeaconRssi] = []
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 7, rssi: -75))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 8, rssi: -75))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 9, rssi: -77))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 10, rssi: -85))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 11, rssi: -88))
        beaconThresholdList5_2.append(BeaconRssi(minor_id: 12, rssi: -89))
        var beaconThresholdList5_3: [BeaconRssi] = []
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 7, rssi: -74))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 8, rssi: -77))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 9, rssi: -75))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 10, rssi: -90))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 11, rssi: -86))
        beaconThresholdList5_3.append(BeaconRssi(minor_id: 12, rssi: -84))
        var beacons5 = [[BeaconRssi]]()
        beacons5.append(beaconThresholdList5_1)
        beacons5.append(beaconThresholdList5_2)
        beacons5.append(beaconThresholdList5_3)
        
        navigations.addNavigationPoint(route_id: 5, navigation_text: "turn right", expectedBeacons: beacons5, isStart: 0, isGoal: 0, isCrossroad: 1, isRoad: 0, rotate_degree: 90, steps: 0)
        
        //ポイント6
        var beaconThresholdList6_1: [BeaconRssi] = []
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 7, rssi: -80))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 8, rssi: -86))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 9, rssi: -88))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 10, rssi: -82))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 11, rssi: -83))
        beaconThresholdList6_1.append(BeaconRssi(minor_id: 12, rssi: -84))
        var beaconThresholdList6_2: [BeaconRssi] = []
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 7, rssi: -84))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 8, rssi: -82))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 9, rssi: -80))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 10, rssi: -83))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 11, rssi: -85))
        beaconThresholdList6_2.append(BeaconRssi(minor_id: 12, rssi: -82))
        var beaconThresholdList6_3: [BeaconRssi] = []
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 7, rssi: -83))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 8, rssi: -81))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 9, rssi: -82))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 10, rssi: -82))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 11, rssi: -84))
        beaconThresholdList6_3.append(BeaconRssi(minor_id: 12, rssi: -85))
        var beacons6 = [[BeaconRssi]]()
        beacons6.append(beaconThresholdList6_1)
        beacons6.append(beaconThresholdList6_2)
        beacons6.append(beaconThresholdList6_3)
        
        navigations.addNavigationPoint(route_id: 6, navigation_text: "straight", expectedBeacons: beacons6, isStart: 0, isGoal: 0, isCrossroad: 0, isRoad: 1, rotate_degree: 0, steps: 10)
        
        //ポイント7
        var beaconThresholdList7_1: [BeaconRssi] = []
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 10, rssi: -78))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 11, rssi: -80))
        beaconThresholdList7_1.append(BeaconRssi(minor_id: 12, rssi: -75))
        var beaconThresholdList7_2: [BeaconRssi] = []
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 10, rssi: -78))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 11, rssi: -75))
        beaconThresholdList7_2.append(BeaconRssi(minor_id: 12, rssi: -81))
        var beaconThresholdList7_3: [BeaconRssi] = []
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 1, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 2, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 3, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 4, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 5, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 6, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 7, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 8, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 9, rssi: -100))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 10, rssi: -78))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 11, rssi: -74))
        beaconThresholdList7_3.append(BeaconRssi(minor_id: 12, rssi: -76))
        var beacons7 = [[BeaconRssi]]()
        beacons7.append(beaconThresholdList7_1)
        beacons7.append(beaconThresholdList7_2)
        beacons7.append(beaconThresholdList7_3)
        
        navigations.addNavigationPoint(route_id: 7, navigation_text: "Goal", expectedBeacons: beacons7, isStart: 0, isGoal: 1, isCrossroad: 1, isRoad: 0, rotate_degree: 0, steps: 0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //IDLE状態からIDLE状態への遷移
    func testCheckLost_IDLE_IDLE(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -85, 2: -82, 3:-83, 4:-83, 5:-85, 6:-83, 7:-100, 8:-100, 9:-100, 10: -100, 11: -100, 12: -100]
        let currentRouteId = 1
        let stateMachineState = 1
        
        //pedometerServiceのモックを作成し、差し替える
        class MocPedometerService : PedometerService{
            //指定の歩数が返るように設定
            public override func get_steps() -> Int {
                return 0
            }
        }
        lostDetectService.pedometerService = MocPedometerService()
        
        //stateをIDLEに設定
        lostDetectService.state = LOST_DETECT_STATE.IDLE
        
        //結果を取得
        let retval = lostDetectService.checkLost(navigations: navigations, currentRouteId: currentRouteId, statemachineState: stateMachineState, receivedBeaconRssiList: receivedBeaconsRssi)
        
        //期待値 retval = 0 state = IDLE
        XCTAssertEqual(retval, 0)
        XCTAssertEqual(lostDetectService.state, LOST_DETECT_STATE.IDLE)
    }
    
    //IDLE状態からCHECK状態への遷移
    func testCheckLost_IDLE_CHECK(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -85, 2: -82, 3:-83, 4:-83, 5:-85, 6:-83, 7:-100, 8:-100, 9:-100, 10: -100, 11: -100, 12: -100]
        let currentRouteId = 2
        let stateMachineState = 1
        
        //pedometerServiceのモックを作成し、差し替える
        class MocPedometerService : PedometerService{
            //指定の歩数が返るように設定
            public override func get_steps() -> Int {
                return 0
            }
        }
        lostDetectService.pedometerService = MocPedometerService()
        
        //stateをIDLEに設定
        lostDetectService.state = LOST_DETECT_STATE.IDLE
        
        //結果を取得
        let retval = lostDetectService.checkLost(navigations: navigations, currentRouteId: currentRouteId, statemachineState: stateMachineState, receivedBeaconRssiList: receivedBeaconsRssi)
        
        //期待値 retval = 0 state = IDLE
        XCTAssertEqual(retval, 1)
        XCTAssertEqual(lostDetectService.state, LOST_DETECT_STATE.CHECK)
    }
    
    //CHECK状態で、歩数が規定以内のとき
    func testCheckLost_CHECK1(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -85, 2: -82, 3:-83, 4:-83, 5:-85, 6:-83, 7:-100, 8:-100, 9:-100, 10: -100, 11: -100, 12: -100]
        let currentRouteId = 2
        let stateMachineState = 1
        
        //pedometerServiceのモックを作成し、差し替える
        class MocPedometerService : PedometerService{
            //指定の歩数が返るように設定
            public override func get_steps() -> Int {
                return 10
            }
        }
        lostDetectService.pedometerService = MocPedometerService()
        
        //stateをCHECKに設定
        lostDetectService.state = LOST_DETECT_STATE.CHECK
        
        //結果を取得
        let retval = lostDetectService.checkLost(navigations: navigations, currentRouteId: currentRouteId, statemachineState: stateMachineState, receivedBeaconRssiList: receivedBeaconsRssi)
        
        //期待値 retval = 0 state = IDLE
        XCTAssertEqual(retval, 1)
        XCTAssertEqual(lostDetectService.state, LOST_DETECT_STATE.CHECK)
    }
    
    //CHECK状態で、歩数が規定範囲外のとき
    func testCheckLost_CHECK2(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -85, 2: -82, 3:-83, 4:-83, 5:-85, 6:-83, 7:-100, 8:-100, 9:-100, 10: -100, 11: -100, 12: -100]
        let currentRouteId = 2
        let stateMachineState = 1
        
        //pedometerServiceのモックを作成し、差し替える
        class MocPedometerService : PedometerService{
            //指定の歩数が返るように設定
            public override func get_steps() -> Int {
                return 50
            }
        }
        lostDetectService.pedometerService = MocPedometerService()
        
        //stateをCHECKに設定
        lostDetectService.state = LOST_DETECT_STATE.CHECK
        
        //結果を取得
        let retval = lostDetectService.checkLost(navigations: navigations, currentRouteId: currentRouteId, statemachineState: stateMachineState, receivedBeaconRssiList: receivedBeaconsRssi)
        
        //期待値 retval = 0 state = IDLE
        XCTAssertEqual(retval, 2)
        XCTAssertEqual(lostDetectService.state, LOST_DETECT_STATE.CHECK)
    }

    //CHECK状態で、規定歩数内で目的地に到達したとき
    func testCheckLost_CHECK3(){
        let receivedBeaconsRssi: Dictionary<Int, Int> = [1: -85, 2: -82, 3:-83, 4:-83, 5:-85, 6:-83, 7:-100, 8:-100, 9:-100, 10: -100, 11: -100, 12: -100]
        let currentRouteId = 3
        let stateMachineState = 1
        
        //pedometerServiceのモックを作成し、差し替える
        class MocPedometerService : PedometerService{
            //指定の歩数が返るように設定
            public override func get_steps() -> Int {
                return 20
            }
        }
        lostDetectService.pedometerService = MocPedometerService()
        
        //stateをCHECKに設定
        lostDetectService.state = LOST_DETECT_STATE.CHECK
        
        //結果を取得
        let retval = lostDetectService.checkLost(navigations: navigations, currentRouteId: currentRouteId, statemachineState: stateMachineState, receivedBeaconRssiList: receivedBeaconsRssi)
        
        //期待値 retval = 0 state = IDLE
        XCTAssertEqual(retval, 0)
        XCTAssertEqual(lostDetectService.state, LOST_DETECT_STATE.IDLE)
    }
    
    func testGetStep(){
        //pedometerServiceのモックを作成し、差し替える
        class MocPedometerService : PedometerService{
            //指定の歩数が返るように設定
            public override func get_steps() -> Int {
                return 20
            }
        }
        lostDetectService.pedometerService = MocPedometerService()
        
        //stateをCHECKに設定
        lostDetectService.state = LOST_DETECT_STATE.CHECK
        
        XCTAssertEqual(lostDetectService.getStep(), 20)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

