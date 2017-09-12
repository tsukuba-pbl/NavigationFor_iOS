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
    
    let navigationService = NavigationService(beaconManager: BeaconManager(), algorithm: KNN())
    let navigations = NavigationEntity()

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
    
    //NoneからNone状態への遷移
    func testNoneState(){
        
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconManager : BeaconManager{
            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
                return [:]
            }
        }
        //NavigationServiceのBeaconManagerをモックに差し替え
        navigationService.beaconManager = MocBeaconManager()
        
        //現在の状態をセット
        navigationService.navigationState = None()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "None")
        XCTAssertEqual(retval.mode, -1)

    }

    //None状態からGoFowardへの遷移
    func testUpdateNavigations_None_to_GoFoward_ByKNN(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconManager : BeaconManager{
            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
                return [1: -100, 2: -100, 3:-90, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-100]
            }
        }
        //NavigationServiceのBeaconManagerをモックに差し替え
        navigationService.beaconManager = MocBeaconManager()

        //現在の状態をセット
        navigationService.navigationState = None()
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "進もう")
        XCTAssertEqual(retval.mode, 1)
    }

    //GoFoward状態からOnThePointへの遷移
    func testUpdateNavigations_GoFoward_to_OnThePoint_ByKNN(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconManager : BeaconManager{
            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
                return [1: -84, 2: -79, 3:-79, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-100]
            }
        }
        //NavigationServiceのBeaconManagerをモックに差し替え
        navigationService.beaconManager = MocBeaconManager()
        //現在の状態をセット
        navigationService.navigationState = GoFoward()
        navigationService.expectedRouteId = 2

        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "turn left")
        XCTAssertEqual(retval.mode, 1)
    }
    
    //GoFoward状態からGoFowardへの遷移
    func testUpdateNavigations_GoFoward_to_GoFoward_ByKNN(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconManager : BeaconManager{
            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
                return [1: -95, 2: -91, 3:-93, 4:-100, 5:-100, 6:-100, 7:-100, 8:-100, 9:-100]
            }
        }
        //NavigationServiceのBeaconManagerをモックに差し替え
        navigationService.beaconManager = MocBeaconManager()
        //現在の状態をセット
        navigationService.navigationState = GoFoward()
        navigationService.expectedRouteId = 2
        
        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "進もう")
        XCTAssertEqual(retval.mode, 1)
    }
    
    //Goal状態からGoalへの遷移
    func testUpdateNavigations_Goal_to_Goal_ByLPF(){
        //テスト用にNavigationServiceのモックを作成
        class MocBeaconManager : BeaconManager{
            //getReceivedBeaconsRssiが指定した値を返すようにオーバーライド
            public override func getReceivedBeaconsRssi() -> Dictionary<Int, Int> {
                return [1: -100, 2: -100, 3:-100, 4:-87, 5:-87, 6:-87, 7:-71, 8:-70, 9:-70]
            }
        }
        //NavigationServiceのBeaconManagerをモックに差し替え
        navigationService.beaconManager = MocBeaconManager()

        //現在の状態をセット
        navigationService.navigationState = Goal()

        //状態遷移を起こす
        let retval = navigationService.updateNavigation(navigations: navigations)
        //テスト
        XCTAssertEqual(retval.navigation_text, "Goal")
        XCTAssertEqual(retval.mode, 2)
    }
    
    func testGetMaxRssiBeacon() {
        class MocBeaconManager: BeaconManager {
            public override func getMaxRssiBeacon() -> (available : Bool, maxRssiBeacon: BeaconEntity) {
                return (true, BeaconEntity(minorId: 1, rssi: -70))
            }
        }
        navigationService.beaconManager = MocBeaconManager()
        
        XCTAssertEqual(navigationService.getMaxRssiBeacon().minorId , 1)
        XCTAssertEqual(navigationService.getMaxRssiBeacon().rssi , -70)
    }

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
