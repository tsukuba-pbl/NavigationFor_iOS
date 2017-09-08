//
//  BeaconLoggerControllerTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/09/08.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
import UIKit
@testable import NavigationForiOS

class BeaconLoggerControllerTests: XCTestCase {
    var beaconLoggerController: BeaconLoggerController!
    var navigations: NavigationEntity!
    var beaconLoggerVC = BeaconLoggerViewController()
    
    override func setUp() {
        super.setUp()
        navigations = NavigationEntity()
        //使用するビーコンを登録
        for i in 1...9{
            navigations.MinorIdList.append(i)
        }
        beaconLoggerController = BeaconLoggerController(navigations: navigations, delegate: beaconLoggerVC)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit(){
        let expected = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(beaconLoggerController.navigations.getMinorList(), expected)
        XCTAssertEqual(beaconLoggerController.state, false)
    }
    
    func testStartBeaconLogger(){
        beaconLoggerController.startBeaconLogger()
        XCTAssertEqual(beaconLoggerController.getCounter, 0)
        XCTAssertTrue(beaconLoggerController.trainData.isEmpty)
        XCTAssertTrue(beaconLoggerController.timer.isValid)
        XCTAssertEqual(beaconLoggerController.state, true)
    }
    
    func testGetLoggerState(){
        let retval = beaconLoggerController.getLoggerState()
        XCTAssertEqual(retval.counter, 0)
        XCTAssertEqual(retval.state, false)
    }
    
    func testGetBeaconRssi(){
        beaconLoggerController.state = true
        beaconLoggerController.getCounter = 0
        var expCounter = 0
        while(beaconLoggerController.state == true){
            XCTAssertEqual(beaconLoggerController.state, true)
            XCTAssertEqual(beaconLoggerController.getCounter, expCounter)
            beaconLoggerController.getBeaconRssi()
            expCounter += 1
        }
        XCTAssertEqual(beaconLoggerController.state, false)
        XCTAssertEqual(beaconLoggerController.getCounter, 10)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
