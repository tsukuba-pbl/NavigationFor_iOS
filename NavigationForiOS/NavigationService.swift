//
//  NavigationService.swift
//  NavigationForiOS
//
//  Created by みなじゅん on 2017/08/18.
//  Copyright © 2017年 UmeSystems. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NavigationService {
    //初期値のroute id
    var initRouteId = 1
    
    //ステートマシンの状態
    var expectedRouteId = 0
    
    //初期状態を設定
    var navigationState: NavigationState
    
    // DI
    var algorithm: AlgorithmBase!       // 適用アルゴリズム
    var beaconManager : BeaconManager!
    
    //音声用
    let speechService = SpeechService()
    
    init(beaconManager: BeaconManager, algorithm: AlgorithmBase) {
        navigationState = None(expectedRouteId: initRouteId)
        self.beaconManager = beaconManager
        self.algorithm = algorithm
    }
        
    /// ナビゲーvarョン情報をサーバからJSON形式で取得
    ///
    /// - Returns: NavigationEntity
    func getNavigationData(responseNavigations: @escaping (NavigationEntity) -> Void){
        let navigation_entity = NavigationEntity()
        let requestUrl = "https://gist.githubusercontent.com/ferretdayo/9ae8f4fda61dfea5e0ddf38b1783460a/raw/d4d5bc555ce9ff34e42242d8c1a8fd317e2219ab/navigationsList.json"
        
        //JSONを取得
        Alamofire.request(requestUrl).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let navJson = JSON(value)
                navJson["routes"].forEach{(_, data) in
                    var beacons = [[BeaconRssi]]()
                    let routeId = data["routeId"].int!
                    let navigation = data["navigation"].string!
                    let isStart = data["isStart"].int!
                    let isGoal = data["isGoal"].int!
                    let isCrossroad = data["isCrossroad"].int!
                    let isRoad = data["isRoad"].int!
                    let rotateDegree = data["rotateDegree"].int!
                    
                    // 各地点のビーコンをbeaconThresholdList配列に格納
                    let beaconsJSON = data["beacons"].array
                    // 教師データの取得（教師データの全体）
                    beaconsJSON?.forEach{(data) in
                        // ビーコンの数だけのminorIdとthresholdを配列に入れる．（教師データの１行）
                        var beaconRssiList: Array<BeaconRssi>! = []
                        data.forEach({ (_, beacon) in
                            let beaconRssi: BeaconRssi = BeaconRssi(minor_id: beacon["minorId"].int, rssi: beacon["rssi"].int)
                            beaconRssiList.append(beaconRssi)
                        })
                        beacons.append(beaconRssiList)
                    }
                    //ナビゲーション情報を順番に格納
                    navigation_entity.addNavigationPoint(route_id: routeId, navigation_text: navigation, expectedBeacons: beacons, isStart: isStart, isGoal: isGoal, isCrossroad: isCrossroad, isRoad: isRoad, rotate_degree: rotateDegree)
                }
            case .failure(let error):
                SlackService.postError(error: error.localizedDescription, tag: "Nagivation Service")
            }
            responseNavigations(navigation_entity)
        }
    }
    
    func initNavigation(navigations: NavigationEntity) {
        self.beaconManager.startBeaconReceiver(navigations: navigations)
    }
    
    //ナビゲーションの更新
    // mode : (1)通常 (2)ゴールに到着 (-1)異常終了
    func updateNavigation(navigations: NavigationEntity) -> (mode : Int, navigation_text : String, navigation_state: String, expected_routeId: Int){
        var navigation_text : String!
        var mode = 1
        let receivedBeaconsRssi = beaconManager.getReceivedBeaconsRssi()
        
        //ナビゲーション情報の更新
        navigationState.updateNavigation(navigationService: self, navigations: navigations, receivedBeaconsRssi: receivedBeaconsRssi, algorithm: algorithm)
        
        //ナビゲーションテキストの取得
        navigation_text = navigationState.getNavigation(navigations: navigations)
        //モードの取得
        mode = navigationState.getMode(navigations: navigations)
        
        //ステートマシンの状態を取得
        let navigationStateMachineProperty = navigationState.getNavigationState()
        
        //音声案内(ステートマシンの状態が遷移したら)
//        if(navigationStateMachineProperty.state == "OnThePoint" && navigationStateMachineProperty.expectedRouteId != expectedRouteId){
//            speechService.textToSpeech(str: navigation_text)
//            expectedRouteId = navigationStateMachineProperty.expectedRouteId
//        }
        
        return (mode, navigation_text, navigationStateMachineProperty.state, navigationStateMachineProperty.expectedRouteId)
    }
    
    
    /// 現在の最大RSSIのビーコン情報を取得
    ///
    /// - Returns: ビーコン情報
    func getMaxRssiBeacon() -> BeaconEntity {
        return beaconManager.getMaxRssiBeacon().maxRssiBeacon
    }
}

