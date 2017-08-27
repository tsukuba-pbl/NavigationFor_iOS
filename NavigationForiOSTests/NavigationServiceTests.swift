//
//  NavigationViewControllerTests.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/17.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import XCTest
@testable import NavigationForiOS

class NavigationServiceTests: XCTestCase {
    
    let navigationService = NavigationService(beaconService: BeaconService())
    let navigations = NavigationEntity()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        navigations.addNavigationPoint(minor_id: 1, threshold: -80, navigation_text: "Start", type: 1)
        navigations.addNavigationPoint(minor_id: 2, threshold: -74, navigation_text: "turn right", type: 0)
        navigations.addNavigationPoint(minor_id: 3, threshold: -65, navigation_text: "turn left", type: 0)
        navigations.addNavigationPoint(minor_id: 4, threshold: -70, navigation_text: "Goal", type: 2)
        navigations.start_minor_id = 1
        navigations.goal_minor_id = 4
        navigationService.initNavigation(navigations: navigations)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //最大RSSIのビーコンが閾値よりも大きい場合(ゴールのビーコンではない)
    //成功時は、mode = 1 minor uuid rssiはそのビーコンの値 navigation_textは、設定した案内情報がリターンされる
    func testUpdateNavigations1(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (flag: Bool, minor: Int, rssi: Int, uuid: String) {
                return (flag: true, minor: 1, rssi:-74, uuid: "12345678-1234-1234-1234-123456789ABC")
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        let retval = navigationService.updateNavigation(navigations: navigations)
        XCTAssertEqual(retval.minor_id, 1)
        XCTAssertEqual(retval.navigation_text, "Start")
        XCTAssertEqual(retval.rssi, -74)
        XCTAssertEqual(retval.uuid, "12345678-1234-1234-1234-123456789ABC")
        XCTAssertEqual(retval.mode, 1)
    }
    
    //最大RSSIのビーコンが閾値よりも小さい場合(ゴールのビーコンではない)
    //成功時は、mode = 1 minor uuid rssiはそのビーコンの値 navigation_textは、「進もう」がリターンされる
    func testUpdateNavigations2(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (flag: Bool, minor: Int, rssi: Int, uuid: String) {
                return (flag: true, minor: 1, rssi:-85, uuid: "12345678-1234-1234-1234-123456789ABC")
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        let retval = navigationService.updateNavigation(navigations: navigations)
        XCTAssertEqual(retval.minor_id, 1)
        XCTAssertEqual(retval.navigation_text, "進もう")
        XCTAssertEqual(retval.rssi, -85)
        XCTAssertEqual(retval.uuid, "12345678-1234-1234-1234-123456789ABC")
        XCTAssertEqual(retval.mode, 1)
    }
    
    //最大RSSIのビーコンが閾値よりも小さい場合(ゴールのビーコンのとき)
    //成功時は、mode = 1 minor uuid rssiはそのビーコンの値 navigation_textは、「進もう」がリターンされる
    func testUpdateNavigations3(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (flag: Bool, minor: Int, rssi: Int, uuid: String) {
                return (flag: true, minor: 4, rssi:-75, uuid: "12345678-1234-1234-1234-123456789ABC")
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        let retval = navigationService.updateNavigation(navigations: navigations)
        XCTAssertEqual(retval.minor_id, 4)
        XCTAssertEqual(retval.navigation_text, "進もう")
        XCTAssertEqual(retval.rssi, -75)
        XCTAssertEqual(retval.uuid, "12345678-1234-1234-1234-123456789ABC")
        XCTAssertEqual(retval.mode, 1)
    }
    
    //最大RSSIのビーコンが閾値よりも大きい場合(ゴールのビーコンのとき)
    //成功時は、mode = 2 minor uuid rssiはそのビーコンの値 navigation_textは、「Goal」がリターンされる
    func testUpdateNavigations4(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (flag: Bool, minor: Int, rssi: Int, uuid: String) {
                return (flag: true, minor: 4, rssi:-60, uuid: "12345678-1234-1234-1234-123456789ABC")
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        let retval = navigationService.updateNavigation(navigations: navigations)
        XCTAssertEqual(retval.minor_id, 4)
        XCTAssertEqual(retval.navigation_text, "Goal")
        XCTAssertEqual(retval.rssi, -60)
        XCTAssertEqual(retval.uuid, "12345678-1234-1234-1234-123456789ABC")
        XCTAssertEqual(retval.mode, 2)
    }
    
    //最大RSSIのビーコンが存在しない場合
    //成功時は、mode = 3
    func testUpdateNavigations5(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (flag: Bool, minor: Int, rssi: Int, uuid: String) {
                return (flag: false, minor: -1, rssi:-100, uuid: "")
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        let retval = navigationService.updateNavigation(navigations: navigations)
        XCTAssertEqual(retval.mode, -1)
    }
    
     func testIsOnNavigationPoint_失敗する場合（閾値よりもRSSIの値が小さい）(){
        let rssi:Int! = -75
        let threshold:Int! = -70
        XCTAssertFalse(self.navigationService.isOnNavigationPoint(RSSI: rssi, threshold: threshold))
     }
     
     func testIsOnNavigationPoint_成功する場合1(){
        let rssi:Int! = -75
        let threshold:Int! = -80
        XCTAssertTrue(self.navigationService.isOnNavigationPoint(RSSI: rssi, threshold: threshold))
     }
     
     func testIsOnNavigationPoint_成功する場合2(){
        let rssi:Int! = -70
        let threshold:Int! = -75
        XCTAssertTrue(self.navigationService.isOnNavigationPoint(RSSI: rssi, threshold: threshold))
     }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}