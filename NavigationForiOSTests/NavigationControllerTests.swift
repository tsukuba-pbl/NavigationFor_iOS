//
//  NavigationViewControllerTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/17.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class NavigationControllerTests: XCTestCase {
    
    let navigationController = NavigationController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        navigationController.getNavigation()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
     
     func testIsOnNavigationPoint_失敗する場合（閾値よりもRSSIの値が小さい）(){
        let rssi:Int! = -75
        let threshold:Int! = -70
        XCTAssertFalse(self.navigationController.isOnNavigationPoint(RSSI: rssi, threshold: threshold))
     }
     
     func testIsOnNavigationPoint_成功する場合1(){
        let rssi:Int! = -75
        let threshold:Int! = -80
        XCTAssertTrue(self.navigationController.isOnNavigationPoint(RSSI: rssi, threshold: threshold))
     }
     
     func testIsOnNavigationPoint_成功する場合2(){
        let rssi:Int! = -70
        let threshold:Int! = -75
        XCTAssertTrue(self.navigationController.isOnNavigationPoint(RSSI: rssi, threshold: threshold))
     }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
