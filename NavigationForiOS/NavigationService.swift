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
    var state = "None"
    
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
        let requestUrl = "https://gist.githubusercontent.com/Minajun/f59deb00034b21342ff79c26d3658fff/raw/691cf8f18632d1627a395e615713ed91a56eb2ba/navigationsList.json"
        
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
        //GoFoward → OnThePointのとき、交差点で設定したナビゲーションを発話
        if(state == "GoFoward" && navigationStateMachineProperty.state == "OnThePoint"){
            speechService.announce(str: navigation_text)
        //OnThePoint → GoFowardのとき、「直進です」を発話
        }else if((state == "OnThePoint" && navigationStateMachineProperty.state == "GoFoward")){
            speechService.announce(str: "直進です")
        }else if(navigationStateMachineProperty.state == "Goal" && state != "Goal"){
            speechService.announce(str: "目的地に到着しました")
        }
        
        //ステートマシンの状態を更新
        state = navigationStateMachineProperty.state
        
        return (mode, navigation_text, navigationStateMachineProperty.state, navigationStateMachineProperty.expectedRouteId)
    }
    
    
    /// 現在の最大RSSIのビーコン情報を取得
    ///
    /// - Returns: ビーコン情報
    func getMaxRssiBeacon() -> BeaconEntity {
        return beaconManager.getMaxRssiBeacon().maxRssiBeacon
    }
}

