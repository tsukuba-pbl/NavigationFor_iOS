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
        navigations.addNavigationPoint(minor_id: 1, threshold: -80, navigation_text: "Start", type: 1)
        navigations.addNavigationPoint(minor_id: 2, threshold: -74, navigation_text: "turn right", type: 0)
        navigations.addNavigationPoint(minor_id: 3, threshold: -65, navigation_text: "turn left", type: 0)
        navigations.addNavigationPoint(minor_id: 4, threshold: -70, navigation_text: "Goal", type: 2)
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
    
    func testCheckRoutes_（成功するとき）(){
        let retval = navigations.checkRoutes(start_id: 1, goal_id: 4)
        XCTAssertTrue(retval)
    }
    
    func testCheckRoutes_（失敗するとき1）(){
        let retval = navigations.checkRoutes(start_id: 1, goal_id: 3)
        XCTAssertFalse(retval)
    }
    
    func testCheckRoutes_（失敗するとき2）(){
        let retval = navigations.checkRoutes(start_id: 2, goal_id: 4)
        XCTAssertFalse(retval)
    }
    
    func testIsAvailableBeaconId_（成功するとき1）(){
        let retval = navigations.isAvailableBeaconId(uuid: "12345678-1234-1234-1234-123456789ABC", minor_id: 1)
        XCTAssertTrue(retval)
        let retval2 = navigations.isAvailableBeaconId(uuid: "12345678-1234-1234-1234-123456789ABC", minor_id: 2)
        XCTAssertTrue(retval2)
    }
    
    func testIsAvailableBeaconId_（失敗するとき1_UUIDが違う）(){
        let retval = navigations.isAvailableBeaconId(uuid: "12345678-1234-1234-1234-123456789ABD", minor_id: 1)
        XCTAssertFalse(retval)
    }
    
    func testIsAvailableBeaconId_（失敗するとき1_minorが違う）(){
        let retval = navigations.isAvailableBeaconId(uuid: "12345678-1234-1234-1234-123456789ABC", minor_id: 6)
        XCTAssertFalse(retval)
    }
    
    func testGetNavigationText_（成功するとき）(){
        let retval1 = navigations.getNavigationText(minor_id: 1)
        XCTAssertEqual(retval1, "Start")
        let retval2 = navigations.getNavigationText(minor_id: 2)
        XCTAssertEqual(retval2, "turn right")
    }
    
    func testGetNavigationText_（失敗するとき）(){
        let retval1 = navigations.getNavigationText(minor_id: 3)
        XCTAssertNotEqual(retval1, "turn right")
        let retval2 = navigations.getNavigationText(minor_id: 4)
        XCTAssertNotEqual(retval2, "Start")
    }
    
    func testGetBeaconThreshold_成功するとき(){
        let retval1 = navigations.getBeaconThreshold(minor_id : 1)
        XCTAssertEqual(retval1, -80)
        let retval2 = navigations.getBeaconThreshold(minor_id : 2)
        XCTAssertEqual(retval2, -74)
        let retval3 = navigations.getBeaconThreshold(minor_id : 3)
        XCTAssertEqual(retval3, -65)
        let retval4 = navigations.getBeaconThreshold(minor_id : 4)
        XCTAssertEqual(retval4, -70)
    }
    
    func testGetBeaconThreshold_失敗するとき(){
        let retval1 = navigations.getBeaconThreshold(minor_id : 1)
        XCTAssertNotEqual(retval1, -74)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
