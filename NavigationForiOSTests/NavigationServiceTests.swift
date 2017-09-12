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
    
//    let navigationService = NavigationService(beaconManager: BeaconManager(), algorithm: Lpf())
//    let navigations = NavigationEntity()
//    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        //ポイント1
//        var beaconThresholdList1: Array<BeaconThreshold>! = []
//        beaconThresholdList1.append(BeaconThreshold(minor_id: 1, threshold: -70))
//        beaconThresholdList1.append(BeaconThreshold(minor_id: 2, threshold: -75))
//        beaconThresholdList1.append(BeaconThreshold(minor_id: 3, threshold: -80))
//        navigations.addNavigationPoint(route_id: 1, navigation_text: "Start", expectedBeacons: beaconThresholdList1)
//        //ポイント2
//        var beaconThresholdList2: Array<BeaconThreshold>! = []
//        beaconThresholdList2.append(BeaconThreshold(minor_id: 4, threshold: -70))
//        beaconThresholdList2.append(BeaconThreshold(minor_id: 5, threshold: -75))
//        beaconThresholdList2.append(BeaconThreshold(minor_id: 6, threshold: -80))
//        navigations.addNavigationPoint(route_id: 2, navigation_text: "turn right", expectedBeacons: beaconThresholdList2)
//        //ポイント3
//        var beaconThresholdList3: Array<BeaconThreshold>! = []
//        beaconThresholdList3.append(BeaconThreshold(minor_id: 7, threshold: -70))
//        beaconThresholdList3.append(BeaconThreshold(minor_id: 8, threshold: -75))
//        beaconThresholdList3.append(BeaconThreshold(minor_id: 9, threshold: -80))
//        navigations.addNavigationPoint(route_id: 3, navigation_text: "turn left", expectedBeacons: beaconThresholdList3)
//        //ポイント4
//        var beaconThresholdList4: Array<BeaconThreshold>! = []
//        beaconThresholdList4.append(BeaconThreshold(minor_id: 10, threshold: -70))
//        beaconThresholdList4.append(BeaconThreshold(minor_id: 11, threshold: -75))
//        beaconThresholdList4.append(BeaconThreshold(minor_id: 12, threshold: -80))
//        navigations.addNavigationPoint(route_id: 4, navigation_text: "Goal", expectedBeacons: beaconThresholdList4)
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testHoge() {
//        navigationService.getNavigationData{ response in
//        }
//    }
//    
//    //None状態からGoFowardへの遷移
//    func testUpdateNavigations_None_to_GoFoward_ByLPF(){
//        //テスト用にNavigationServiceのモックを作成
//        class MocBeaconManager : BeaconManager{
//            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
//            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
//                return [1: -100, 2: -100, 3:-90, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-100, 10:-100, 11:-100, 12:-100]
//            }
//        }
//        //NavigationServiceのBeaconManagerをモックに差し替え
//        navigationService.beaconManager = MocBeaconManager()
//        
//        //現在の状態をセット
//        navigationService.navigationState = None()
//        //状態遷移を起こす
//        let retval = navigationService.updateNavigation(navigations: navigations)
//        //テスト
//        XCTAssertEqual(retval.navigation_text, "進もう")
//        XCTAssertEqual(retval.mode, 1)
//    }
//    
//    //GoFoward状態からOnThePointへの遷移
//    func testUpdateNavigations_GoFoward_to_OnThePoint_ByLPF(){
//        //テスト用にNavigationServiceのモックを作成
//        class MocBeaconManager : BeaconManager{
//            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
//            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
//                return [1: -95, 2: -90, 3:-90, 4:-60, 5:-70, 6:-80, 7:-100, 8:-100, 9:-100, 10:-100, 11:-100, 12:-100]
//            }
//        }
//        //NavigationServiceのBeaconManagerをモックに差し替え
//        navigationService.beaconManager = MocBeaconManager()
//        //現在の状態をセット
//        navigationService.navigationState = GoFoward()
//        
//        //状態遷移を起こす
//        let retval = navigationService.updateNavigation(navigations: navigations)
//        //テスト
//        XCTAssertEqual(retval.navigation_text, "turn right")
//        XCTAssertEqual(retval.mode, 1)
//    }
//
//    //OnThePoint状態からGoFowardへの遷移
//    func testUpdateNavigations_OnThePoint_to_GoFoward_ByLPF(){
//        //テスト用にNavigationServiceのモックを作成
//        class MocBeaconManager : BeaconManager{
//            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
//            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
//                return [1: -100, 2: -100, 3:-90, 4:-100, 5:-90, 6:-89, 7:-100, 8:-100, 9:-100, 10:-100, 11:-100, 12:-100]
//            }
//        }
//        //NavigationServiceのBeaconManagerをモックに差し替え
//        navigationService.beaconManager = MocBeaconManager()
//        
//        //現在の状態をセット
//        navigationService.navigationState = OnThePoint()
//        
//        //状態遷移を起こす
//        let retval = navigationService.updateNavigation(navigations: navigations)
//        //テスト
//        XCTAssertEqual(retval.navigation_text, "進もう")
//        XCTAssertEqual(retval.mode, 1)
//    }
//    
//    //OnThePoint状態からGoalへの遷移
//    func testUpdateNavigations_OnThePoint_to_Goal_ByLPF(){
//        //テスト用にNavigationServiceのモックを作成
//        class MocBeaconManager : BeaconManager{
//            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
//            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
//                return [1: -100, 2: -100, 3:-90, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-90, 10:-80, 11:-70, 12:-75]
//            }
//        }
//        //NavigationServiceのBeaconManagerをモックに差し替え
//        navigationService.beaconManager = MocBeaconManager()
//        
//        //現在の状態をセット
//        navigationService.navigationState = OnThePoint()
//        
//        //状態遷移を起こす
//        let retval = navigationService.updateNavigation(navigations: navigations)
//        //テスト
//        XCTAssertEqual(retval.navigation_text, "Goal")
//        XCTAssertEqual(retval.mode, 2)
//    }
//
//    //GoFoward状態からGoalへの遷移
//    func testUpdateNavigations_GoFoward_to_Goal_ByLPF(){
//        //テスト用にNavigationServiceのモックを作成
//        class MocBeaconManager : BeaconManager{
//            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
//            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
//                return [1: -100, 2: -100, 3:-90, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-90, 10:-80, 11:-70, 12:-75]
//            }
//        }
//        //NavigationServiceのBeaconManagerをモックに差し替え
//        navigationService.beaconManager = MocBeaconManager()
//        //現在の状態をセット
//        navigationService.navigationState = GoFoward()
//        
//        //状態遷移を起こす
//        let retval = navigationService.updateNavigation(navigations: navigations)
//        //テスト
//        XCTAssertEqual(retval.navigation_text, "Goal")
//        XCTAssertEqual(retval.mode, 2)
//    }
//
//    //Goal状態からGoalへの遷移
//    func testUpdateNavigations_Goal_to_Goal_ByLPF(){
//        //テスト用にNavigationServiceのモックを作成
//        class MocBeaconManager : BeaconManager{
//            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
//            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
//                return [1: -100, 2: -100, 3:-90, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-100, 10:-70, 11:-70, 12:-60]
//            }
//        }
//        //NavigationServiceのBeaconManagerをモックに差し替え
//        navigationService.beaconManager = MocBeaconManager()
//        
//        //現在の状態をセット
//        navigationService.navigationState = Goal()
//        
//        // LPF
//        navigationService.algorithm = Lpf()
//        
//        //状態遷移を起こす
//        let retval = navigationService.updateNavigation(navigations: navigations)
//        //テスト
//        XCTAssertEqual(retval.navigation_text, "Goal")
//        XCTAssertEqual(retval.mode, 2)
//    }
//    
//    func testGetMaxRssiBeacon() {
//        class MocBeaconManager: BeaconManager {
//            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
//                return (true, BeaconEntity(minorId: 1, rssi: -70))
//            }
//        }
//        navigationService.beaconManager = MocBeaconManager()
//        
//        XCTAssertEqual(navigationService.getMaxRssiBeacon().minorId , 1)
//        XCTAssertEqual(navigationService.getMaxRssiBeacon().rssi , -70)
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
