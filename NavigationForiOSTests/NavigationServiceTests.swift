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
    
    //None状態からGoFowardへの遷移
    func testUpdateNavigations_None_to_GoFoward(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (available: true, maxRssiBeacon: BeaconEntity(minorId: 2, rssi:-90))
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        //現在の状態をセット
        navigationService.navigationState = None()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "進もう")
        XCTAssertEqual(retval.mode, 1)
        XCTAssertEqual(retval.maxRssiBeacon.minorId, 2)
        XCTAssertEqual(retval.maxRssiBeacon.rssi, -90)
    }
    
    //GoFoward状態からNoneへの遷移
    func testUpdateNavigations_GoFoward_to_None(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (available: false, maxRssiBeacon: BeaconEntity(minorId: -1, rssi:-100))
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        //現在の状態をセット
        navigationService.navigationState = GoFoward()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "None")
        XCTAssertEqual(retval.mode, -1)
        XCTAssertEqual(retval.maxRssiBeacon.minorId, -1)
        XCTAssertEqual(retval.maxRssiBeacon.rssi, -100)
    }
    
    //GoFoward状態からOnThePointへの遷移
    func testUpdateNavigations_GoFoward_to_OnThePoint(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (available: true, maxRssiBeacon: BeaconEntity(minorId: 2, rssi:-70))
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        //現在の状態をセット
        navigationService.navigationState = GoFoward()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "turn right")
        XCTAssertEqual(retval.mode, 1)
        XCTAssertEqual(retval.maxRssiBeacon.minorId, 2)
        XCTAssertEqual(retval.maxRssiBeacon.rssi, -70)
    }

    //OnThePoint状態からGoFowardへの遷移
    func testUpdateNavigations_OnThePoint_to_GoFoward(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (available: true, maxRssiBeacon: BeaconEntity(minorId: 3, rssi:-90))
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        //現在の状態をセット
        navigationService.navigationState = OnThePoint()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "進もう")
        XCTAssertEqual(retval.mode, 1)
        XCTAssertEqual(retval.maxRssiBeacon.minorId, 3)
        XCTAssertEqual(retval.maxRssiBeacon.rssi, -90)
    }
    
    //OnThePoint状態からGoalへの遷移
    func testUpdateNavigations_OnThePoint_to_Goal(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (available: true, maxRssiBeacon: BeaconEntity(minorId: 4, rssi:-65))
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        //現在の状態をセット
        navigationService.navigationState = OnThePoint()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "Goal")
        XCTAssertEqual(retval.mode, 2)
        XCTAssertEqual(retval.maxRssiBeacon.minorId, 4)
        XCTAssertEqual(retval.maxRssiBeacon.rssi, -65)
    }

    //GoFoward状態からGoalへの遷移
    func testUpdateNavigations_GoFoward_to_Goal(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (available: true, maxRssiBeacon: BeaconEntity(minorId: 4, rssi:-60))
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        //現在の状態をセット
        navigationService.navigationState = GoFoward()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "Goal")
        XCTAssertEqual(retval.mode, 2)
        XCTAssertEqual(retval.maxRssiBeacon.minorId, 4)
        XCTAssertEqual(retval.maxRssiBeacon.rssi, -60)
    }

    //Goal状態からGoalへの遷移
    func testUpdateNavigations_Goal_to_Goal(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconService : BeaconService{
            //getMaxRssiBeaconが指定した値を返すようにオーバーライド
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (available: true, maxRssiBeacon: BeaconEntity(minorId: 4, rssi:-55))
            }
        }
        //NavigationServiceのBeaconServiceをモックに差し替え
        let beaconservice = MocBeaconService()
        navigationService.beaconservice = beaconservice
        //現在の状態をセット
        navigationService.navigationState = Goal()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "Goal")
        XCTAssertEqual(retval.mode, 2)
        XCTAssertEqual(retval.maxRssiBeacon.minorId, 4)
        XCTAssertEqual(retval.maxRssiBeacon.rssi, -55)
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
