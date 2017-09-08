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
    
    override func setUp() {
        super.setUp()
        navigations = NavigationEntity()
        //使用するビーコンを登録
        for i in 1...9{
            navigations.MinorIdList.append(i)
        }
        beaconLoggerController = BeaconLoggerController(navigations: navigations)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit(){
        let expected = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(beaconLoggerController.navigations.getMinorList(), expected)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
